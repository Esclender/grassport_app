import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/main.dart' as app;

import 'package:integration_test/integration_test.dart';

testPreviews(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('Saltar'), findsOneWidget);
  await Future.delayed(const Duration(seconds: 2));

  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    setUpAll(() async {
      app.main();
    });

    testWidgets('Grassport app started', (tester) async {
      await tester.pumpAndSettle();
      expect(find.text('GrasSport'), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle();

      await testPreviews(tester);
    });
  });
}
