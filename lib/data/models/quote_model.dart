import 'package:equatable/equatable.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';

class QuoteModel extends QuoteEntity with EquatableMixin {
  QuoteModel({
    required String quote,
    required int id,
    required String author,
  }) : super(quote: quote, id: id, author: author);

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    // return QuoteModel(
    //   quote: json['text'],
    //   author: json['author'],
    //   id: json['id'],
    // );
    return QuoteModel(
      quote: json['advice'],
      author: 'Someone',
      id: json['advice_id'],
    );
  }
}
