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
    validateName(name);
    if (state.value is HomeStateEmpty &&
        (state.value as HomeStateEmpty).error == null) {
      _nameRepository.addName(name);
      reloadNames();
    }
  }

  void validateName(String name) {
    if (name.isEmpty) {
      if (state.value is HomeStateEmpty) {
        state.value = (state.value as HomeStateEmpty)
            .copyWith(error: 'Nome não pode ser vazio');
        return;
      }
      state.value = HomeStateEmpty(error: 'Nome não pode ser vazio');
    }
  }

  Future<void> reloadNames() async {
    if (state.value is HomeStateEmpty) {
      state.value = (state.value as HomeStateEmpty).copyWith(isLoading: true);
    } else {
      state.value = HomeStateLoading();
    }
    await Future.delayed(const Duration(seconds: 2));
    state.value =
        HomeStateEmpty(names: _nameRepository.getNames(), isLoading: false);
  }

  void removeName(int index) {}
}
