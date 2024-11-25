sealed class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}

class HomeStateSuccess extends HomeState {
  final List<String> names;

  HomeStateSuccess(this.names);
}
