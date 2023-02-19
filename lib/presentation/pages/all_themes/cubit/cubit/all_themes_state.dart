part of 'all_themes_cubit.dart';

abstract class AllThemesState extends Equatable {
  const AllThemesState();

  @override
  List<Object> get props => [];
}

class AllThemesInitial extends AllThemesState {
  const AllThemesInitial();
}

class AllThemesStateLoading extends AllThemesState {
  const AllThemesStateLoading();
}

class AllThemesStateLoaded extends AllThemesState {
  final List<GroupEntity> groups;
  const AllThemesStateLoaded({required this.groups});

  @override
  List<Object> get props => [groups];
}

class AllThemesStateError extends AllThemesState {
  final String message;
  const AllThemesStateError({required this.message});
  @override
  List<Object> get props => [message];
}
