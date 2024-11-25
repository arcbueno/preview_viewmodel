sealed class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}

class HomeStateEmpty extends HomeState {
  final List<String> names;
  final List<String> surnames;
  final bool isLoading;
  final String? error;

  HomeStateEmpty({
    this.names = const <String>[],
    this.surnames = const <String>[],
    this.isLoading = false,
    this.error,
  });

  HomeStateEmpty copyWith({
    List<String>? names,
    List<String>? surnames,
    bool? isLoading,
    String? error,
  }) {
    return HomeStateEmpty(
      names: names ?? this.names,
      surnames: surnames ?? this.surnames,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
