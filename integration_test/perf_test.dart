import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Pruebas de rendimiento app grassport', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Slide of swiper', (tester) async {
      await tester.pumpWidget(const BlocsProvider());
      await tester.pumpAndSettle();

      await binding.traceAction(() async {
        for (var i = 0; i < 3; i++) {
          Finder button = find.byKey(const Key('Previews - Next Preview btn'));

          await tester.tap(button);
          await tester.pumpAndSettle();
        }
      }, reportKey: 'slides_summary');
    });
  });
}
