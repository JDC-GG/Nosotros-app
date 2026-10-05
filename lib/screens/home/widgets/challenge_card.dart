import 'package:flutter/material.dart';

import '../../../models/challenge.dart';
import '../../../models/challenge_session.dart';
import 'couple_progress.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeSession? session;

  const ChallengeCard({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return _buildEmptyCard();
    }

    final challenge = session!.challenge;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8EC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            _categoryEmoji(challenge.category),
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            _categoryName(challenge.category),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE85D75),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            challenge.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            challenge.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          CoupleProgress(
            userCompleted: session!.userCompleted,
            partnerCompleted: session!.partnerCompleted,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8EC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Text(
            '❤️ RETO DEL DÍA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE85D75),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Lanza el dado para descubrir qué tendrán que hacer juntos.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _categoryEmoji(ChallengeCategory category) {
    switch (category) {
      case ChallengeCategory.romantico:
        return '❤️';
      case ChallengeCategory.divertido:
        return '😂';
      case ChallengeCategory.salir:
        return '📍';
      case ChallengeCategory.casa:
        return '🏠';
      case ChallengeCategory.pregunta:
        return '💬';
      case ChallengeCategory.atrevido:
        return '😈';
    }
  }

  String _categoryName(ChallengeCategory category) {
    switch (category) {
      case ChallengeCategory.romantico:
        return 'ROMÁNTICO';
      case ChallengeCategory.divertido:
        return 'DIVERTIDO';
      case ChallengeCategory.salir:
        return 'SALIR';
      case ChallengeCategory.casa:
        return 'EN CASA';
      case ChallengeCategory.pregunta:
        return 'PREGUNTA';
      case ChallengeCategory.atrevido:
        return 'ATREVIDO';
    }
  }
}