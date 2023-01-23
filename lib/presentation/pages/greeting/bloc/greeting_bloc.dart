import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'greeting_event.dart';
part 'greeting_state.dart';

class GreetingBloc extends Bloc<GreetingEvent, GreetingState> {
  GreetingBloc() : super(GreetingInitial()) {
    on<GreetingRequestedEvent>((event, emit) async {
      emit(GreetingStateLoading());
      await Future.delayed(const Duration(seconds: 3), () {});
      //emit(const GreetingStateLoaded(quote: 'act because you can'));
      emit(const GreetingStateError(message: 'error message'));
    });
  }
}
