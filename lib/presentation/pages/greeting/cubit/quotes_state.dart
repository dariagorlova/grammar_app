part of 'quotes_cubit.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class QuotesInitial extends QuotesState {
  const QuotesInitial();
}

class QuotesStateLoading extends QuotesState {
  const QuotesStateLoading();
}

class QuotesStateLoaded extends QuotesState {
  final QuoteEntity quote;
  const QuotesStateLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class QuotesStateError extends QuotesState {
  final String message;
  const QuotesStateError({required this.message});
  @override
  List<Object> get props => [message];
}
