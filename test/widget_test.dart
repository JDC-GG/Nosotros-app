import 'package:flutter_test/flutter_test.dart';

import 'package:nosotros/app.dart';

void main() {
  testWidgets('Nosotros app inicia correctamente', (tester) async {
    await tester.pumpWidget(const NosotrosApp());

    expect(find.text('Nosotros ❤️'), findsOneWidget);
    expect(find.text('¿Qué hacemos hoy?'), findsOneWidget);
  });
}
