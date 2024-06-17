import '../events/switch_events.dart';
import '../../core/event.dart';
import '../../core/basic_state_machine.dart';
import '../../core/state.dart';
import '../../core/trans.dart';
import '../states/button_state.dart';
import 'trans_methods.dart';

class ButtonStateMachine extends BasicStateMachine {
  ButtonStateMachine(super.currentState);

  @override
  void create() {
    states_[ButtonState.state_(ButtonStates.ready)] = State([
      Trans(Disable(),  ButtonState.state_(ButtonStates.disabled),  OnDisable()),
      Trans(Down(),     ButtonState.state_(ButtonStates.pressed),   OnPress()),
      Trans(ChangeText(),   ButtonState.state_(ButtonStates.ready),     OnNothing())
    ]);

    states_[ButtonState.state_(ButtonStates.pressed)] = State([
      Trans(Reset(), ButtonState.state_(ButtonStates.ready), OnNothing()),
      Trans(Up(), ButtonState.state_(ButtonStates.ready), OnUnpress())
    ]);

    states_[ButtonState.state_(ButtonStates.disabled)] = State([
      Trans(Enable(), ButtonState.state_(ButtonStates.ready), OnEnable()),
    ]);
  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    String result = ButtonStates.values[state].name;
    return result;
  }

  @override
  void publishEvent(Event event) {
    // TODO: implement publishEvent
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }
}
