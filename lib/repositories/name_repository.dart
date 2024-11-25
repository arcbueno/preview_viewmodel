class NameRepository {
  final List<String> _names = ['Teste'];

  void addName(String name) {
    _names.add(name);
  }

  void removeName(String name) {
    _names.remove(name);
  }

  // Criando função apenas para fingir algo assíncrono
  List<String> getNames() {
    return _names;
  }

  List<String> getSurnames() {
    return _names;
  }
}
