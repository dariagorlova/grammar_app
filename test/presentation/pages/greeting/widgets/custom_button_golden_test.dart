import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/custom_button.dart';

void main() {
  Widget widgetUnderTest({Function()? onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(
          onTap: onTap,
        ),
      ),
    );
  }

  group(
    'Golden Test',
    () {
      group(
        'Custom Button',
        () {
          testWidgets(
            'is enabled',
            (widgetTester) async {
              await widgetTester.pumpWidget(widgetUnderTest(
                onTap: () {},
              ));

              await expectLater(find.byType(CustomButton),
                  matchesGoldenFile('goldens/custom_button_enabled.png'));
            },
          );

          testWidgets(
            'is disabled',
            (widgetTester) async {
              await widgetTester.pumpWidget(widgetUnderTest());

              await expectLater(find.byType(CustomButton),
                  matchesGoldenFile('goldens/custom_button_disabled.png'));
            },
          );
        },
      );
    },
  );
}
