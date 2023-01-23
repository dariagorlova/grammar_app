import 'package:dartz/dartz.dart';
import 'package:grammar_app/data/repositories/quotes_repo_impl.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'quotes_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<QuotesRepoImpl>()])
void main() {
  group('AdviceUsecases', () {
    group('should return QuoteEntitiy', () {
      test('when QuotesRepoImpl returns a QuoteModel', () async {
        final mockQuotesRepoImpl = MockQuotesRepoImpl();
        final quotesUseCaseUnderTest =
            QuotesUseCases(quotesRepo: mockQuotesRepoImpl);

        when(mockQuotesRepoImpl.getQuoteFromDatasource()).thenAnswer(
            (realInvocation) => Future.value(const Right(
                QuoteEntity(quote: 'test', id: 42, author: 'author'))));

        final result = await quotesUseCaseUnderTest.getQuote();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            const Right<Failure, QuoteEntity>(
                QuoteEntity(quote: 'test', id: 42, author: 'author')));
        verify(mockQuotesRepoImpl.getQuoteFromDatasource()).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead .called(0)
        verifyNoMoreInteractions(mockQuotesRepoImpl);
      });
    });

    group('should return left with', () {
      test('a ServerFailure', () async {
        final mockQuotesRepoImpl = MockQuotesRepoImpl();
        final quotesUseCaseUnderTest =
            QuotesUseCases(quotesRepo: mockQuotesRepoImpl);

        when(mockQuotesRepoImpl.getQuoteFromDatasource()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await quotesUseCaseUnderTest.getQuote();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, QuoteEntity>(ServerFailure()));
        verify(mockQuotesRepoImpl.getQuoteFromDatasource()).called(1);
        verifyNoMoreInteractions(mockQuotesRepoImpl);
      });

      test('a GeneralFailure', () async {
        // arrange
        final mockQuotesRepoImpl = MockQuotesRepoImpl();
        final quotesUseCaseUnderTest =
            QuotesUseCases(quotesRepo: mockQuotesRepoImpl);

        when(mockQuotesRepoImpl.getQuoteFromDatasource()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));

        // act
        final result = await quotesUseCaseUnderTest.getQuote();

        // assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, QuoteEntity>(GeneralFailure()));
        verify(mockQuotesRepoImpl.getQuoteFromDatasource()).called(1);
        verifyNoMoreInteractions(mockQuotesRepoImpl);
      });
    });
  });
}
