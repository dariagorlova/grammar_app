import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';
import 'package:grammar_app/presentation/pages/greeting/cubit/quotes_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

class MockQuotesUseCases extends Mock implements QuotesUseCases {}

void main() {
  group('QuotesCubit', () {
    group(
      'should emit',
      () {
        MockQuotesUseCases mockQuotesUseCases = MockQuotesUseCases();

        blocTest(
          'nothing when no method is called',
          build: () => QuotesCubit(
            quoteUseCases: mockQuotesUseCases,
          ),
          expect: () => const <QuotesState>[],
        );

        blocTest(
          '[QuotesStateLoading, QuotesStateLoaded] when quoteRequested() is called',
          setUp: () => when(() => mockQuotesUseCases.getQuote()).thenAnswer(
            (invocation) => Future.value(
              const Right<Failure, QuoteEntity>(
                QuoteEntity(quote: 'quote', id: 1, author: 'author'),
              ),
            ),
          ),
          build: () => QuotesCubit(
            quoteUseCases: mockQuotesUseCases,
          ),
          act: (cubit) => cubit.quoteRequested(),
          expect: () => const <QuotesState>[
            QuotesStateLoading(),
            QuotesStateLoaded(
              quote: QuoteEntity(
                quote: 'quote',
                id: 1,
                author: 'author',
              ),
            )
          ],
        );

        group(
          '[QuotesStateLoading, QuotesStateError] when quoteRequested() is called',
          () {
            blocTest(
              'and a ServerFailure occors',
              setUp: () => when(() => mockQuotesUseCases.getQuote()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, QuoteEntity>(
                    ServerFailure(),
                  ),
                ),
              ),
              build: () => QuotesCubit(
                quoteUseCases: mockQuotesUseCases,
              ),
              act: (cubit) => cubit.quoteRequested(),
              expect: () => const <QuotesState>[
                QuotesStateLoading(),
                QuotesStateError(message: serverFailureMessage),
              ],
            );

            blocTest(
              'and a CacheFailure occors',
              setUp: () => when(() => mockQuotesUseCases.getQuote()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, QuoteEntity>(
                    CacheFailure(),
                  ),
                ),
              ),
              build: () => QuotesCubit(
                quoteUseCases: mockQuotesUseCases,
              ),
              act: (cubit) => cubit.quoteRequested(),
              expect: () => const <QuotesState>[
                QuotesStateLoading(),
                QuotesStateError(message: cacheFailureMessage),
              ],
            );

            blocTest(
              'and a GeneralFailure occors',
              setUp: () => when(() => mockQuotesUseCases.getQuote()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, QuoteEntity>(
                    GeneralFailure(),
                  ),
                ),
              ),
              build: () => QuotesCubit(
                quoteUseCases: mockQuotesUseCases,
              ),
              act: (cubit) => cubit.quoteRequested(),
              expect: () => const <QuotesState>[
                QuotesStateLoading(),
                QuotesStateError(message: generalFailureMessage),
              ],
            );
          },
        );
      },
    );
  });
}
