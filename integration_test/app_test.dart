import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/main.dart';
import 'package:grassport_app/presentation/screens/StartingApp/previews.dart';
import 'package:grassport_app/presentation/screens/home_app/admin_views/admin_home.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

void main() {
  group('Pruebas de integracion app grassport', () {
    testWidgets('Test de verificacion de cambio de color de swiper',
        (tester) async {
      await tester.pumpWidget(const BlocsProvider());

      expect(find.text('GrasSport'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      final swipersKeys = [
        'Swiper 1',
        'Swiper 2',
        'Swiper 3',
      ];
      //BUCLE QUE VERIFICA CADA UNO DE LOS SWIPERS
      for (String swiper in swipersKeys) {
        final Finder swiperFinder = find.byKey(ValueKey(swiper));

        print(swiperFinder);

        final Swipers swiperActual = tester.widget(swiperFinder);

        //VERIFICAMOS QUE SU COLOR CAMBIE
        expect(swiperActual.colorSwiper, equals(c8));

        await Future.delayed(const Duration(seconds: 2));
        Finder button = find.byKey(const Key('Previews - Next Preview btn'));
        await tester.tap(button);

        await tester.pumpAndSettle();
      }
    });

    // testWidgets('Test de filtrado de usuarios en admin', (tester) async {
    //   await tester.pumpWidget(const BlocsProvider());
    //   await tester.pumpAndSettle();

    //   await tester.runAsync(() async {
    //     expect(find.text('GrasSport'), findsOneWidget);

    //     await Future.delayed(const Duration(seconds: 2));

    //     await tester.pumpAndSettle();
    //     await tester.pumpAndSettle();
    //     await tester.pumpAndSettle();

    //     final Finder saltarBtn = find.byKey(
    //       const Key("saltar"),
    //     );

    //     await tester.tap(saltarBtn);
    //     await tester.pumpAndSettle();
    //     await tester.pumpAndSettle();

    //     final Finder loginBtn = find.byKey(const Key('login'));
    //     final Finder emailInput = find.byKey(const Key('emailInput'));
    //     final Finder claveInput = find.byKey(const Key('passwordInput'));

    //     await tester.enterText(emailInput, 'elesclenderlugo@gmail.com');
    //     await tester.testTextInput.receiveAction(TextInputAction.done);
    //     await tester.enterText(claveInput, '1234');
    //     await tester.testTextInput.receiveAction(TextInputAction.done);

    //     await tester.tap(loginBtn);

    //     await tester.pumpAndSettle();

    //     expect(find.byType(AdminView), findsOneWidget);
    //   });
    // });
  });
}
