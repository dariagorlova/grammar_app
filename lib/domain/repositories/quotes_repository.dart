import 'package:dartz/dartz.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';

abstract class QuotesRepository {
  Future<Either<Failure, QuoteEntity>> getQuoteFromDatasource();
}
