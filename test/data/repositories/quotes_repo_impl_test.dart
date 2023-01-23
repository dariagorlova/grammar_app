import 'package:dartz/dartz.dart';
import 'package:grammar_app/data/datasources/quotes_local_datasource.dart';
import 'package:grammar_app/data/exceptions/exceptions.dart';
import 'package:grammar_app/data/models/quote_model.dart';
import 'package:grammar_app/data/repositories/quotes_repo_impl.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'quotes_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<QuotesLocalDatasourceImpl>()])
void main() {
  group('QuoteRepoImpl', () {
    group('should return QuoteEntitiy', () {
      test('when QuotesLocalDatasource returns a QuoteModel', () async {
        final mockQuotesLocalDatasource = MockQuotesLocalDatasourceImpl();
        final quotesRepoImplUnderTest =
            QuotesRepoImpl(quotesLocalDatasource: mockQuotesLocalDatasource);

        when(mockQuotesLocalDatasource.getRandomQuoteFromRepo()).thenAnswer(
            (realInvocation) => Future.value(
                QuoteModel(quote: 'test', id: 42, author: 'author')));

        final result = await quotesRepoImplUnderTest.getQuoteFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            Right<Failure, QuoteModel>(
                QuoteModel(quote: 'test', id: 42, author: 'author')));
        verify(mockQuotesLocalDatasource.getRandomQuoteFromRepo()).called(1);
        verifyNoMoreInteractions(mockQuotesLocalDatasource);
      });
    });

    group('should retrun left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockQuotesLocalDatasource = MockQuotesLocalDatasourceImpl();
        final quotesRepoImplUnderTest =
            QuotesRepoImpl(quotesLocalDatasource: mockQuotesLocalDatasource);

        when(mockQuotesLocalDatasource.getRandomQuoteFromRepo())
            .thenThrow(ServerException());

        final result = await quotesRepoImplUnderTest.getQuoteFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, QuoteEntity>(ServerFailure()));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockQuotesLocalDatasource = MockQuotesLocalDatasourceImpl();
        final quotesRepoImplUnderTest =
            QuotesRepoImpl(quotesLocalDatasource: mockQuotesLocalDatasource);

        when(mockQuotesLocalDatasource.getRandomQuoteFromRepo())
            .thenThrow(ServerException());

        final result = await quotesRepoImplUnderTest.getQuoteFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, QuoteEntity>(ServerFailure()));
      });
    });
  });
}
