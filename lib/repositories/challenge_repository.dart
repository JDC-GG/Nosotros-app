import 'dart:math';

import '../data/challenges.dart';
import '../models/challenge.dart';

class ChallengeRepository {
  final Random _random;

  ChallengeRepository({
    Random? random,
  }) : _random = random ?? Random();

  Challenge getRandomChallenge() {
    return challenges[_random.nextInt(challenges.length)];
  }
}