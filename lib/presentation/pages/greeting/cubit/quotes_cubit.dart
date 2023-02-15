import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';

part 'quotes_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit({required this.quoteUseCases}) : super(const QuotesInitial()) {
    init();
  }

  final QuotesUseCases quoteUseCases;
  //final GrammarNavigator router;

  void init() {
    quoteRequested();
  }

  void quoteRequested() async {
    emit(const QuotesStateLoading());

    final failureOrQuote = await quoteUseCases.getQuote();
    failureOrQuote.fold(
        (failure) =>
            emit(QuotesStateError(message: _mapFailureToMessage(failure))),
        (quote) => emit(QuotesStateLoaded(quote: quote)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
