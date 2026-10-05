import 'challenge.dart';

enum ChallengeStatus {
  idle,
  rolled,
  accepted,
  inProgress,
  waitingPartner,
  completed,
}

class ChallengeSession {
  final Challenge challenge;
  final ChallengeStatus status;
  final bool userCompleted;
  final bool partnerCompleted;

  const ChallengeSession({
    required this.challenge,
    this.status = ChallengeStatus.rolled,
    this.userCompleted = false,
    this.partnerCompleted = false,
  });

  ChallengeSession copyWith({
    ChallengeStatus? status,
    bool? userCompleted,
    bool? partnerCompleted,
  }) {
    return ChallengeSession(
      challenge: challenge,
      status: status ?? this.status,
      userCompleted: userCompleted ?? this.userCompleted,
      partnerCompleted: partnerCompleted ?? this.partnerCompleted,
    );
  }
}