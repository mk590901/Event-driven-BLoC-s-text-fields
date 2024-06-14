import 'package:equatable/equatable.dart';

abstract class TextFieldEvent extends Equatable {
  const TextFieldEvent();

  @override
  List<Object> get props => [];
}

class TextChanged extends TextFieldEvent {
  final String text;

  const TextChanged(this.text);

  @override
  List<Object> get props => [text];
}

class TextSubmitted extends TextFieldEvent {
  final String text;

  const TextSubmitted(this.text);

  @override
  List<Object> get props => [text];
}
