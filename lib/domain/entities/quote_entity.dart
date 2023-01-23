import 'package:equatable/equatable.dart';

class QuoteEntity extends Equatable {
  final int id;
  final String quote;
  final String author;

  const QuoteEntity(
      {required this.quote, required this.id, required this.author});

  @override
  List<Object?> get props => [quote, id, author];
}
