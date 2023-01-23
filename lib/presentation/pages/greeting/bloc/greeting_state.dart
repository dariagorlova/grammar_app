part of 'greeting_bloc.dart';

abstract class GreetingState extends Equatable {
  const GreetingState();

  @override
  List<Object> get props => [];
}

class GreetingInitial extends GreetingState {}

class GreetingStateLoading extends GreetingState {}

class GreetingStateLoaded extends GreetingState {
  final String quote;
  const GreetingStateLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class GreetingStateError extends GreetingState {
  final String message;
  const GreetingStateError({required this.message});

  @override
  List<Object> get props => [message];
}
