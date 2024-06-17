class Pair<F, S> {
  final F _first;
  final S _second;

  Pair(this._first, this._second);

  @override
  String toString() {
    return 'Pair[$_first, $_second]';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pair && runtimeType == other.runtimeType && _first == other._first && _second == other._second;

  @override
  int get hashCode => _first.hashCode ^ _second.hashCode;

  F first () => _first;
  S second() => _second;
}
