import 'package:equatable/equatable.dart';

abstract class TextFieldState extends Equatable {
  const TextFieldState();

  @override
  List<Object> get props => [];
}

class TextFieldInitial extends TextFieldState {}

class TextFieldChanged extends TextFieldState {
  final String text;

  const TextFieldChanged(this.text);

  @override
  List<Object> get props => [text];
}
