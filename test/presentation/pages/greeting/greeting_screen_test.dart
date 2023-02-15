import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/core/services/theme_service.dart';
import 'package:grammar_app/presentation/pages/greeting/cubit/quotes_cubit.dart';
import 'package:grammar_app/presentation/pages/greeting/greeting_screen.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/error_message.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/quote_field.dart';
import 'package:provider/provider.dart';

class MockQuotesCubit extends MockCubit<QuotesState> implements QuotesCubit {}

void main() {
  Widget widgetUnderTest({required QuotesCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<QuotesCubit>(
          create: (context) => cubit,
          child: const GreetingScreen(),
        ),
      ),
    );
  }

  group(
    'GreetingPage',
    () {
      late QuotesCubit mockQuotesCubit;

      setUp(
        () {
          mockQuotesCubit = MockQuotesCubit();
        },
      );
      group(
        'should be displayed in ViewState',
        () {
          testWidgets(
            'Initial when cubits emits QuotesInitial()',
            (widgetTester) async {
              whenListen(
                mockQuotesCubit,
                Stream.fromIterable(const [QuotesInitial()]),
                initialState: const QuotesInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockQuotesCubit));

              final quotesInitalTextFinder =
                  find.text('Your Quote is waiting for you!');

              expect(quotesInitalTextFinder, findsOneWidget);
            },
          );

          testWidgets(
            'Loading when cubits emits QuotesStateLoading()',
            (widgetTester) async {
              whenListen(
                mockQuotesCubit,
                Stream.fromIterable(const [QuotesStateLoading()]),
                initialState: const QuotesInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockQuotesCubit));
              await widgetTester.pump();

              final quotesLoadingFinder =
                  find.byType(CircularProgressIndicator);

              expect(quotesLoadingFinder, findsOneWidget);
            },
          );

          testWidgets(
            'advice text when cubits emits QuotesStateLoaded()',
            (widgetTester) async {
              whenListen(
                mockQuotesCubit,
                Stream.fromIterable(const [
                  QuotesStateLoaded(
                      quote: QuoteEntity(quote: '42', id: 0, author: 'Someone'))
                ]),
                initialState: const QuotesInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockQuotesCubit));
              await widgetTester.pump();

              final quotesLoadedStateFinder = find.byType(QuoteField);
              final quoteText = widgetTester
                  .widget<QuoteField>(quotesLoadedStateFinder)
                  .quote;

              expect(quotesLoadedStateFinder, findsOneWidget);
              expect(quoteText.quote, '42');
            },
          );

          testWidgets(
            'Error when cubits emits AdvicerStateError()',
            (widgetTester) async {
              whenListen(
                mockQuotesCubit,
                Stream.fromIterable(const [QuotesStateError(message: 'error')]),
                initialState: const QuotesInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockQuotesCubit));
              await widgetTester.pump();

              final advicerErrorFinder = find.byType(ErrorMessage);

              expect(advicerErrorFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
