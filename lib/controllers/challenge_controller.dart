import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/challenge_session.dart';
import '../repositories/challenge_repository.dart';
import '../repositories/local_storage_repository.dart';

class ChallengeController extends ChangeNotifier {
  final ChallengeRepository _challengeRepository;
  final LocalStorageRepository _storageRepository;

  ChallengeController({
    ChallengeRepository? challengeRepository,
    LocalStorageRepository? storageRepository,
  })  : _challengeRepository =
            challengeRepository ?? ChallengeRepository(),
        _storageRepository =
            storageRepository ?? LocalStorageRepository();

  ChallengeSession? _session;
  bool _isRolling = false;
  bool _isInitialized = false;

  int _streak = 0;
  int _loveCoins = 0;

  DateTime? _lastCompletedDate;

  Timer? _rollTimer;
  Timer? _partnerTimer;

  ChallengeSession? get session => _session;
  bool get isRolling => _isRolling;

  int get streak => _streak;
  int get loveCoins => _loveCoins;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _streak = await _storageRepository.getStreak();
    _loveCoins = await _storageRepository.getLoveCoins();
    _lastCompletedDate =
        await _storageRepository.getLastCompletedDate();

    _isInitialized = true;

    notifyListeners();
  }

  void rollDice() {
    if (_isRolling || !_isInitialized) return;

    _isRolling = true;
    _session = null;

    notifyListeners();

    _rollTimer?.cancel();

    _rollTimer = Timer(
      const Duration(milliseconds: 700),
      () {
        final challenge = _challengeRepository.getRandomChallenge();

        _session = ChallengeSession(
          challenge: challenge,
          status: ChallengeStatus.rolled,
        );

        _isRolling = false;

        notifyListeners();
      },
    );
  }

  void acceptChallenge() {
    if (_session == null) return;

    _session = _session!.copyWith(
      status: ChallengeStatus.inProgress,
    );

    notifyListeners();
  }

  void completeChallenge() {
    if (_session == null) return;
    if (_session!.userCompleted) return;

    _session = _session!.copyWith(
      userCompleted: true,
      status: ChallengeStatus.waitingPartner,
    );

    notifyListeners();

    _simulatePartnerCompletion();
  }

  void _simulatePartnerCompletion() {
    _partnerTimer?.cancel();

    _partnerTimer = Timer(
      const Duration(seconds: 2),
      () async {
        if (_session == null) return;

        _session = _session!.copyWith(
          partnerCompleted: true,
          status: ChallengeStatus.completed,
        );

        await _registerCompletion();

        notifyListeners();
      },
    );
  }

  Future<void> _registerCompletion() async {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final lastDate = _lastCompletedDate == null
        ? null
        : DateTime(
            _lastCompletedDate!.year,
            _lastCompletedDate!.month,
            _lastCompletedDate!.day,
          );

    final alreadyCompletedToday =
        lastDate != null && _isSameDay(lastDate, today);

    if (!alreadyCompletedToday) {
      if (lastDate != null && _isYesterday(lastDate, today)) {
        _streak++;
      } else {
        _streak = 1;
      }

      _lastCompletedDate = today;
    }

    _loveCoins += 50;

    await _storageRepository.saveStats(
      streak: _streak,
      loveCoins: _loveCoins,
      lastCompletedDate: _lastCompletedDate ?? today,
    );
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  bool _isYesterday(DateTime previous, DateTime today) {
    final difference = today.difference(previous).inDays;

    return difference == 1;
  }

  void reset() {
    _rollTimer?.cancel();
    _partnerTimer?.cancel();

    _session = null;
    _isRolling = false;

    notifyListeners();
  }

  @override
  void dispose() {
    _rollTimer?.cancel();
    _partnerTimer?.cancel();

    super.dispose();
  }
}