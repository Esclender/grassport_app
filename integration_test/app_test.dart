import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/main.dart' as app;

import 'package:integration_test/integration_test.dart';

testPreviews(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.byKey(const Key("VistaPrevius")), findsOneWidget);
  await Future.delayed(const Duration(seconds: 2));
  Finder button = find.byKey(const Key('Previews - Next Preview btn'));
  await tester.tap(button);

  await tester.pumpAndSettle();
}

testclickSaltar(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.byKey(const Key("VistaPrevius")), findsOneWidget);
  await Future.delayed(const Duration(seconds: 2));
  Finder button = find.byKey(const Key("saltar"));
  await tester.tap(button);
  await tester.pumpAndSettle();
  //buscar por texto iniciar sesion con google
  expect(find.text("Iniciar sesion con Google"), findsOneWidget);
  await tester.pumpAndSettle();
}

testIniciaDespues(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
  Finder button = find.byKey(const Key("iniciaDespues"));
  await tester.tap(button);
  await tester.pumpAndSettle();
  expect(find.text("Permisos de ubicacion"), findsOneWidget);
  await tester.pumpAndSettle();
}

testSesionManualmente(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
  Finder button = find.byKey(const Key("manualmente"));
  await tester.tap(button);
  await tester.pumpAndSettle();
  expect(find.text("Busquedas recientes"), findsOneWidget);

  expect(find.text("Direcciones guardadas"), findsOneWidget);
  await tester.pumpAndSettle();
}

testBuscar(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
  final textFieldFinder = find.byKey(const Key("buscar"));

  await tester.enterText(textFieldFinder, 'La Pascana');

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();

  expect(find.text("La Pascana, Comas, Peru"), findsOneWidget);

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

      await testclickSaltar(tester);

      await testIniciaDespues(tester);

      await testSesionManualmente(tester);

      await testBuscar(tester);
    });
  });
}
