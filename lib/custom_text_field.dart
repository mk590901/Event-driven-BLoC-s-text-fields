import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/text_field_bloc.dart';
import 'bloc/text_field_event.dart';
import 'bloc/text_field_state.dart';
import 'callback_fun_type.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late TextFieldBloc textFieldBloc;
  final VoidCallbackParameter? callback;

  CustomTextField(this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        textFieldBloc = TextFieldBloc();
        textFieldBloc.add(TextChanged('init'));
        return textFieldBloc;
      },
      child: BlocBuilder<TextFieldBloc, TextFieldState>(
        builder: (context, state) {
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
              callback?.call(formattedText);
            },
            onSubmitted: (text) {
              textFieldBloc.add(TextSubmitted(text));
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your text here...',
            ),
          );
        },
      ),
    );
  }
}
