import 'package:flutter/material.dart';
import 'package:preview_viewmodel/pages/home/home_state.dart';
import 'package:preview_viewmodel/pages/home/home_viewmodel.dart';
import 'package:preview_viewmodel/repositories/name_repository.dart';

class HomePage extends StatelessWidget {
  final viewModel =
      HomeViewModel(NameRepository()); // Recebe por injeção de dependência
  final TextEditingController nameController = TextEditingController();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text('Olá, seja bem-vindo!'),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Digite um nome',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.addName(nameController.text);
                          nameController.text = '';
                        },
                        child: const Text('Save'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await viewModel.reloadNames();
                        },
                        child: const Text('Reload'),
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<HomeState>(
                valueListenable: viewModel.state,
                builder: (context, state, child) {
                  if (state is HomeStateLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Offstage(
                    offstage: state is! HomeStateSuccess,
                    child: ListView.builder(
                      itemCount: (state as HomeStateSuccess).names.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MYLisTile(
                          name: (state).names[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MYLisTile extends StatelessWidget {
  final String name;
  const MYLisTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
    );
  }
}
