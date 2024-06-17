import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/text_events.dart';
import '../../core/event.dart';
import '../../core/basic_state_machine.dart';
import '../state_machines/text_state_machine.dart';
import '../states/text_state.dart';

class TextBloc extends Bloc<Event, TextState> {
  BasicStateMachine? _stateMachine;

  //TextBloc(super.state) {
  TextBloc(TextState initialState) : super(initialState) {
    //_stateMachine = TextStateMachine(TextState.state_(TextStates.idle));
    _stateMachine = TextStateMachine(initialState.state().index);

    on<Submitted>((event, emit) {
      done(event, emit);
    });
    on<Changed>((event, emit) {
      done(event, emit);
    });
    on<Enable>((event, emit) {
      done(event, emit);
    });
    on<Disable>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<TextState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      TextState nextState = TextState(TextStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
