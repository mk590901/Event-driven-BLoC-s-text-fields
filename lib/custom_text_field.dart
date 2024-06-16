// lib/custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/text_field_bloc.dart';
import 'bloc/text_field_event.dart';
import 'bloc/text_field_state.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldBloc, TextFieldState>(
      builder: (context, state) {
        final textFieldBloc = BlocProvider.of<TextFieldBloc>(context);

        if (state is TextFieldChanged) {
          _controller.value = _controller.value.copyWith(
            text: state.text,
            selection: TextSelection.collapsed(offset: state.text.length),
          );
        }

        return TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,  // Makes the TextField multiline
          onChanged: (text) {
            // Example of formatting: capitalize every letter
            String formattedText = text.toUpperCase();
            textFieldBloc.add(TextChanged(formattedText));
          },
          onSubmitted: (text) {
            textFieldBloc.add(TextSubmitted(text));
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your text here...',
          ),
        );
      },
    );
  }
}
