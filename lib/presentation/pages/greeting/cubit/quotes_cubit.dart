import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grammar_app/data/exceptions/exceptions_constants.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';

part 'quotes_state.dart';

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
            emit(QuotesStateError(message: mapFailureToMessage(failure))),
        (quote) => emit(QuotesStateLoaded(quote: quote)));
  }
}
