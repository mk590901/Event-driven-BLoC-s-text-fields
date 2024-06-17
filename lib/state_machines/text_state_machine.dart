import '../events/text_events.dart';
import '../events/event.dart';
import 'trans_methods.dart';
import '../states/text_state.dart';
import 'basic_state_machine.dart';
import 'state.dart';
import 'trans.dart';

class TextStateMachine extends BasicStateMachine {
  TextStateMachine(super.currentState);

  @override
  void create() {

    states_[TextState.state_(TextStates.ready)] = State([
      Trans(Submitted(),  TextState.state_(TextStates.ready),    OnSubmitted()),
      Trans(Changed(),    TextState.state_(TextStates.ready),    OnChanged()),
      Trans(Disable(),    TextState.state_(TextStates.disabled), OnDisable())
    ]);

    states_[TextState.state_(TextStates.disabled)] = State([
      Trans(Enable(),     TextState.state_(TextStates.ready),    OnEnable())
    ]);


    // states_[TextState.state_(TextStates.idle)] = State([
    //     Trans(Submitted(),  TextState.state_(TextStates.idle),    OnSubmitted()),
    //     Trans(Changed(),    TextState.state_(TextStates.changed), OnChanged())
    //     ]);
    //
    // states_[TextState.state_(TextStates.changed)] = State([
    //     Trans(Submitted(),  TextState.state_(TextStates.idle),    OnSubmitted()),
    //     Trans(Changed(),    TextState.state_(TextStates.changed), OnChanged())
    // ]);

  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    String result = TextStates.values[state].name;
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
