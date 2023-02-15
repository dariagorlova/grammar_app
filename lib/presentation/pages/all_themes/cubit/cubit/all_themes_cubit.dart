import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_themes_state.dart';

class AllThemesCubit extends Cubit<AllThemesState> {
  AllThemesCubit() : super(AllThemesInitial()) {
    init();
  }

  void init() {
    //
  }

  void goToTheme() {
    //router.goToTheme();
  }
}
