import 'package:flutter/material.dart';

class CoupleProgress extends StatelessWidget {
  final bool userCompleted;
  final bool partnerCompleted;

  const CoupleProgress({
    super.key,
    required this.userCompleted,
    required this.partnerCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _UserStatus(
          emoji: '👤',
          label: 'Tú',
          completed: userCompleted,
        ),
        const SizedBox(width: 35),
        _UserStatus(
          emoji: '❤️',
          label: 'Tu pareja',
          completed: partnerCompleted,
        ),
      ],
    );
  }
}

class _UserStatus extends StatelessWidget {
  final String emoji;
  final String label;
  final bool completed;

  const _UserStatus({
    required this.emoji,
    required this.label,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 26),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          completed ? '✅ Listo' : '⏳ Pendiente',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: completed ? Colors.green : Colors.orange,
          ),
        ),
      ],
    );
  }
}