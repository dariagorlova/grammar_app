import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/quote_field.dart';

void main() {
  Widget widgetUnderTest({required String quoteText}) {
    final quote = QuoteEntity(quote: quoteText, id: 0, author: '');
    return MaterialApp(
      home: QuoteField(quote: quote),
    );
  }

  group(
    'AdviceField',
    () {
      group(
        'should be displayed correctly',
        () {
          testWidgets(
            'when a short text is given',
            (widgetTester) async {
              const text = 'a';

              await widgetTester.pumpWidget(widgetUnderTest(quoteText: text));
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.textContaining('a');

              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when a long text is given',
            (widgetTester) async {
              const text =
                  'Hello flutter developers, i hope you enjoy the course, and have a great time. The sun is shining, i have no idea what else i should write here to get a very long text.';

              await widgetTester.pumpWidget(widgetUnderTest(quoteText: text));
              await widgetTester.pumpAndSettle();

              final quoteFieldFinder = find.byType(QuoteField);

              expect(quoteFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when no text is given',
            (widgetTester) async {
              const text = '';

              await widgetTester.pumpWidget(widgetUnderTest(quoteText: text));
              await widgetTester.pumpAndSettle();

              final quoteFieldFinder = find.text(QuoteField.emptyQuote);
              final quoteText = widgetTester
                  .widget<QuoteField>(find.byType(QuoteField))
                  .quote;

              expect(quoteFieldFinder, findsOneWidget);
              expect(quoteText.quote, '');
            },
          );
        },
      );
    },
  );
}
