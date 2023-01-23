import 'package:bloc_test/bloc_test.dart';
import 'package:grammar_app/presentation/pages/greeting/bloc/greeting_bloc.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('GreetingBloc', () {
    group('should emits', () {
      blocTest<GreetingBloc, GreetingState>(
        'nothing when no event is added',
        build: () => GreetingBloc(),
        expect: () => const <GreetingState>[],
      );

      blocTest(
        '[GreetingStateLoading, GreetingStateError] when GreetingRequestedEvent is added',
        build: () => GreetingBloc(),
        act: (bloc) => bloc.add(GreetingRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <GreetingState>[
          GreetingStateLoading(),
          const GreetingStateError(message: 'error message'),
        ],
      );
    });
  });
}
