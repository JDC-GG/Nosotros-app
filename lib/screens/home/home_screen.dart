import 'package:flutter/material.dart';

import '../../controllers/challenge_controller.dart';
import '../../models/challenge_session.dart';
import 'widgets/challenge_button.dart';
import 'widgets/challenge_card.dart';
import 'widgets/dice_widget.dart';
import 'widgets/stat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChallengeController _controller = ChallengeController();

  int _selectedIndex = 0;

 @override
void initState() {
  super.initState();

  _controller.addListener(_onControllerChanged);

  _initializeController();
}

Future<void> _initializeController() async {
  await _controller.initialize();
 }
  void _onControllerChanged() {
    if (!mounted) return;

    setState(() {});

    final session = _controller.session;

    if (session?.status == ChallengeStatus.completed) {
      _showCompletionDialog();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Nosotros ❤️',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildHome(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.casino_outlined),
            selectedIcon: Icon(Icons.casino),
            label: 'Retos',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined),
            selectedIcon: Icon(Icons.local_fire_department),
            label: 'Racha',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Nosotros',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _buildStats(),

            const SizedBox(height: 35),

            const Text(
              '¿Qué hacemos hoy?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Text(
              'Dejen que el azar decida por ustedes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            DiceWidget(
              isRolling: _controller.isRolling,
              hasChallenge: _controller.session != null,
            ),

            const SizedBox(height: 40),

            ChallengeButton(
              session: _controller.session,
              isRolling: _controller.isRolling,
              onRoll: _controller.rollDice,
              onAccept: _controller.acceptChallenge,
              onComplete: _controller.completeChallenge,
            ),

            const SizedBox(height: 25),

            ChallengeCard(
              session: _controller.session,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            emoji: '🔥',
            value: '${_controller.streak}',
            label: 'días de racha',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            emoji: '❤️',
            value: '${_controller.loveCoins}',
            label: 'LoveCoins',
          ),
        ),
      ],
    );
  }

  void _showCompletionDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            title: const Text(
              '🎉 ¡Reto completado!',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Los dos lo lograron.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  '🔥 +1 día de racha',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '❤️ +50 LoveCoins',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CONTINUAR'),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}