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
        child: ValueListenableBuilder<HomeState>(
            valueListenable: viewModel.state,
            builder: (context, state, child) {
              return Center(
                child: state is HomeStateLoading
                    ? const CircularProgressIndicator()
                    : Stack(
                        children: [
                          Column(
                            children: [
                              const Text('Olá, seja bem-vindo!'),
                              TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Digite um nome',
                                ),
                              ),
                              Text(
                                  state is HomeStateEmpty
                                      ? (state).error ?? ''
                                      : '',
                                  style: const TextStyle(color: Colors.red)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          viewModel
                                              .addName(nameController.text);
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
                              Column(
                                children: [
                                  Offstage(
                                    offstage: state is! HomeStateEmpty,
                                    child: ListView.builder(
                                      itemCount: (state as HomeStateEmpty)
                                          .names
                                          .length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return MYLisTile(
                                          name: (state).names[index],
                                          onPressed: () {
                                            viewModel.removeName(index);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Offstage(
                                    offstage: state is! HomeStateEmpty,
                                    child: ListView.builder(
                                      itemCount: (state).surnames.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return MYLisTile(
                                          name: (state).surnames[index],
                                          onPressed: () {
                                            viewModel.removeName(index);
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          if (state.isLoading)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
              );
            }),
      ),
    );
  }
}

class MYLisTile extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  const MYLisTile({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      // trailing: Row(
      //   children: [
      //     IconButton(
      //       icon: const Icon(Icons.edit),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.remove),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
    );
  }
}
