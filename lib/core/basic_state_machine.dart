import 'event.dart';
import 'state.dart';
import 'transaction.dart';

abstract class BasicStateMachine {
  late int _currentState;
  final Map<int, State> states_ = <int, State>{};

//  Constructor
  BasicStateMachine(this._currentState) {
    create();
  }

  int dispatch(Event event) {
    State? stateEntity = states_[_currentState];
    if (stateEntity == null || stateEntity.size() == 0) {
      print("Failed to get State [${getStateName(_currentState)}]");
      return -1;
    }

    Transaction? transaction = stateEntity.transaction(event);
    if (transaction == null) {
      print(
          """
Failed to get transaction for [${getStateName(_currentState)}], event->${event}""");
      return -1;
    }
    _currentState = transaction.state();

    transaction.method()?.execute(event.getData());

    return _currentState;
  }

  void create(); //  abstract function
  void publishState(int state); //  abstract function
  void publishEvent(Event event); //  abstract function
  String? getStateName(int state); //  abstract function
  String? getEventName(int event); //  abstract function

  int state() {
    return _currentState;
  }

  void setState(int state) {
    _currentState = state;
  }
}
