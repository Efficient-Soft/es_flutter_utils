extension IterableDistinctBy<T> on Iterable<T> {
  List<T> distinctBy<K>(K Function(T) keyOf) {
    final seen = <K>{};
    return where((e) => seen.add(keyOf(e))).toList();
  }
}
