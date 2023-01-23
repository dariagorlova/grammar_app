import 'dart:convert';
import 'dart:math';
import 'package:grammar_app/data/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import 'package:grammar_app/data/models/quote_model.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

abstract class QuotesLocalDatasource {
  /// requests a random quote from local db
  /// returns [QuoteModel] if successfull
  /// throws a server-Exception if status code is not 200
  Future<QuoteModel> getRandomQuoteFromRepo();
}

// class QuotesLocalDatasourceImpl implements QuotesLocalDatasource {
//   final http.Client client;
//   QuotesLocalDatasourceImpl({required this.client});

//   @override
//   Future<QuoteModel> getRandomQuoteFromRepo() async {
//     var jsonText = await rootBundle.loadString('assets/quotes.json');

//     final data = json.decode(jsonText);

//     final randomIndex = Random().nextInt(11);

//     final currentQuote = QuoteModel(
//       quote: data[randomIndex]['text'],
//       id: data[randomIndex]['id'],
//       author: data[randomIndex]['author'],
//     );

//     //return QuoteModel.fromJson(data[0]);
//     return currentQuote;
//   }
// }

class QuotesLocalDatasourceImpl implements QuotesLocalDatasource {
  final http.Client client;
  QuotesLocalDatasourceImpl({required this.client});

  @override
  Future<QuoteModel> getRandomQuoteFromRepo() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {
        'content-type': 'application/json ',
      },
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      return QuoteModel.fromJson(responseBody);
    }
    //final responseBody = json.decode('assets/quotes.json');
    //return QuoteModel.fromJson(responseBody);
  }
}
