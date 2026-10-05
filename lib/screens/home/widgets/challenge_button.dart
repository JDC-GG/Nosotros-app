import 'package:flutter/material.dart';

import '../../../models/challenge_session.dart';

class ChallengeButton extends StatelessWidget {
  final ChallengeSession? session;
  final bool isRolling;
  final VoidCallback onRoll;
  final VoidCallback onAccept;
  final VoidCallback onComplete;

  const ChallengeButton({
    super.key,
    required this.session,
    required this.isRolling,
    required this.onRoll,
    required this.onAccept,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return _button(
        onPressed: isRolling ? null : onRoll,
        icon: Icons.casino,
        label: isRolling ? 'LANZANDO...' : 'LANZAR DADO',
      );
    }

    switch (session!.status) {
      case ChallengeStatus.rolled:
        return _button(
          onPressed: onAccept,
          label: 'ACEPTAR RETO',
        );

      case ChallengeStatus.accepted:
      case ChallengeStatus.inProgress:
        return _button(
          onPressed: onComplete,
          icon: Icons.check,
          label: 'MARCAR COMO COMPLETADO',
        );

      case ChallengeStatus.waitingPartner:
        return _button(
          onPressed: null,
          icon: Icons.hourglass_top,
          label: 'ESPERANDO A TU PAREJA...',
        );

      case ChallengeStatus.completed:
        return _button(
          onPressed: onRoll,
          icon: Icons.casino,
          label: 'NUEVO RETO',
        );

      case ChallengeStatus.idle:
        return _button(
          onPressed: onRoll,
          icon: Icons.casino,
          label: 'LANZAR DADO',
        );
    }
  }

  Widget _button({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: icon == null
          ? FilledButton(
              onPressed: onPressed,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}