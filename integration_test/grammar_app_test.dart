import 'package:flutter_test/flutter_test.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/quote_field.dart';
import 'package:integration_test/integration_test.dart';
import 'package:grammar_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end-to-end test',
    () {
      testWidgets(
        'tap on custom button, verify advice will be loaded',
        (widgetTester) async {
          app.main();
          await widgetTester.pumpAndSettle();

          // Verify that no advice has been loaded
          expect(find.text('Your Quote is waiting for you!'), findsOneWidget);

          // Find custom button
          final customButtonFinder = find.text('Get Quote');

          // Emulate a tap on the custom button
          await widgetTester.tap(customButtonFinder);

          // Trigger a frame and wait until its settled
          await widgetTester.pumpAndSettle();

          // Verify that a advice was loaded
          expect(find.byType(QuoteField), findsOneWidget);
          expect(find.textContaining('" '), findsOneWidget);
          //expect(find.textContaining(' "'), findsOneWidget);
        },
      );
    },
  );
}
