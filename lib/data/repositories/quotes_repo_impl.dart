import 'package:dartz/dartz.dart';
import 'package:grammar_app/data/datasources/quotes_local_datasource.dart';
import 'package:grammar_app/data/exceptions/exceptions.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/repositories/quotes_repository.dart';

import '../../domain/failuries/failures.dart';

class QuotesRepoImpl implements QuotesRepository {
  final QuotesLocalDatasource quotesLocalDatasource;
  QuotesRepoImpl({required this.quotesLocalDatasource});

  @override
  Future<Either<Failure, QuoteEntity>> getQuoteFromDatasource() async {
    try {
      final result = await quotesLocalDatasource.getRandomQuoteFromRepo();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
