import 'package:dartz/dartz.dart';
import 'package:grammar_app/data/repositories/quotes_repo_impl.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:grammar_app/domain/repositories/quotes_repository.dart';

class QuotesUseCases {
  final QuotesRepository quotesRepo;
  QuotesUseCases({required this.quotesRepo});

  Future<Either<Failure, QuoteEntity>> getQuote() async {
    return quotesRepo.getQuoteFromDatasource();
    // space for business logic
  }
}
