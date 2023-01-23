import 'package:grammar_app/data/datasources/quotes_local_datasource.dart';
import 'package:grammar_app/data/exceptions/exceptions.dart';
import 'package:grammar_app/data/models/quote_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';

import 'quotes_local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('QuoteLocalDatasource', () {
    group('should return QuoteModel', () {
      test('when Client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest =
            QuotesLocalDatasourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json ',
          },
        )).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        final result =
            await adviceRemoteDatasourceUnderTest.getRandomQuoteFromRepo();

        expect(
            result, QuoteModel(quote: 'test advice', id: 1, author: 'Someone'));
      });
    });

    group('should throw', () {
      test('a ServerException when Client response was not 200', () {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest =
            QuotesLocalDatasourceImpl(client: mockClient);

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json ',
          },
        )).thenAnswer((realInvocation) => Future.value(Response('', 201)));

        expect(() => adviceRemoteDatasourceUnderTest.getRandomQuoteFromRepo(),
            throwsA(isA<ServerException>()));
      });

      test('a Type Error when Client response was 200 and has no valid data',
          () {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest =
            QuotesLocalDatasourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice"}';

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json ',
          },
        )).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        expect(() => adviceRemoteDatasourceUnderTest.getRandomQuoteFromRepo(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
