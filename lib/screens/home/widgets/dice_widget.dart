import 'package:flutter/material.dart';

class DiceWidget extends StatelessWidget {
  final bool isRolling;
  final bool hasChallenge;

  const DiceWidget({
    super.key,
    required this.isRolling,
    required this.hasChallenge,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFE85D75),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE85D75).withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Center(
        child: isRolling
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              )
            : Text(
                hasChallenge ? '❤️' : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}