import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/main.dart';
import 'package:grassport_app/presentation/screens/chargeScreens/main_charge.dart';

Widget createHomeScreen() => const BlocsProvider();

testclickSaltar(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.byKey(const Key("VistaPrevius")), findsOneWidget);
  await Future.delayed(const Duration(seconds: 2));
  Finder button = find.byKey(const Key("saltar"));
  await tester.tap(button);
  await tester.pumpAndSettle();
}

testSesionManualmente(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
  Finder button = find.byKey(const Key("manualmente"));
  await tester.tap(button);
  await tester.pumpAndSettle();
  expect(find.text("Busquedas recientes"), findsOneWidget);
}

testBuscar(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
  final textFieldFinder = find.byKey(const Key("buscar"));

  await tester.enterText(textFieldFinder, 'La Pascana');

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 5));

  await tester.pumpAndSettle();

  expect(find.text("La Pascana, Comas, Peru"), findsOneWidget);

  await tester.pumpAndSettle();
}

void main() {
  group('Grassport Pruebas Widgets', () {
    testWidgets('LogoAnimation bottom to Top', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.runAsync(() async {
        await Future.delayed(const Duration(seconds: 2));

        final Finder logoAnimationFinder = find.byType(LogoAnimation);

        expect(logoAnimationFinder, findsOneWidget);

        await tester.pump();

        final LogoAnimation logoAnimation = tester.widget(logoAnimationFinder);
        expect(logoAnimation.alignment, equals(Alignment.center));
      });
    });

    // testWidgets('Pantalla de carga aparece', (tester) async {
    //   await tester.pumpWidget(createHomeScreen());

    //   await tester.runAsync(() async {
    //     await testclickSaltar(tester);

    //     final Finder emailInput = find.byKey(const Key('emailInput'));
    //     final Finder claveInput = find.byKey(const Key('passwordInput'));
    //     final Finder loginBtn = find.byKey(const Key('login'));

    //     await tester.tap(loginBtn);
    //     await tester.enterText(emailInput, 'gilmer48mm.@gmail.com');
    //     await tester.enterText(claveInput, '1234');

    //     await tester.pumpAndSettle();
    //     await tester.pumpAndSettle();
    //     await tester.pumpAndSettle();

    //     await testSesionManualmente(tester);
    //   });
    // });
  });
}
