enum TextStates { idle, changed, disable }

class TextState {

  static int state_(TextStates state) {
    return state.index;
  }

  final TextStates _state;
  String? _data;

  TextState(this._state) {
    _data = null;
  }

  TextStates state() {
    return _state;
  }

  void setData(String? data) {
    _data = data;
  }

  String? data() {
    return _data;
  }
}
