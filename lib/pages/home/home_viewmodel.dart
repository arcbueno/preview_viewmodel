import 'package:flutter/material.dart';
import 'package:preview_viewmodel/pages/home/home_state.dart';
import 'package:preview_viewmodel/repositories/name_repository.dart';

class HomeViewModel {
  final NameRepository _nameRepository;

  final ValueNotifier<HomeState> state = ValueNotifier(HomeStateLoading());

  HomeViewModel(this._nameRepository) {
    reloadNames();
  }

  void addName(String name) {
    _nameRepository.addName(name);
    reloadNames();
  }

  Future<void> reloadNames() async {
    state.value = HomeStateLoading();
    await Future.delayed(const Duration(seconds: 2));
    state.value = HomeStateSuccess(_nameRepository.getNames());
  }
}
