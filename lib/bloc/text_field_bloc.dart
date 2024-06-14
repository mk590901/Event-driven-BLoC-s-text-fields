import 'package:flutter_bloc/flutter_bloc.dart';
import 'text_field_event.dart';
import 'text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc() : super(TextFieldInitial()) {
    on<TextChanged>((event, emit) {
      emit(TextFieldChanged(event.text));
    });
    on<TextSubmitted>((event, emit) {
      // You can handle the submission logic here
      // For now, we'll just emit the same TextFieldChanged state
      emit(TextFieldChanged(event.text));
    });

  }
}
