import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/text_field_bloc.dart';
import 'bloc/text_field_event.dart';
import 'bloc/text_field_state.dart';
import 'callback_fun_type.dart';
import 'events/text_events.dart';
import 'state_machines/text_bloc.dart';
import 'states/text_state.dart';

class CustomText extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late TextBloc textFieldBloc;
  final VoidCallbackParameter? callback;
  final String initText;

  CustomText(this.initText, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        textFieldBloc = TextBloc(TextState(TextStates.idle));
        if (initText.isNotEmpty) {
          textFieldBloc.add(Changed(initText));
        }
        return textFieldBloc;
      },
      child: BlocBuilder<TextBloc, TextState>(
        builder: (context, state) {
//          if (state.state() == TextStates.changed) {
          //if (state.state() == TextStates.idle) {
            _controller.value = _controller.value.copyWith(
              text: state.data(),
//              selection: TextSelection.collapsed(offset: (state.data() as String).length),
              selection: TextSelection.collapsed(offset: state.data() != null ? (state.data() as String).length : 0),

            );
          //}

          return TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: null,  // Makes the TextField multiline
            enabled: (state.state() == TextStates.idle),
            onChanged: (text) {
              // Example of formatting: capitalize every letter
              String formattedText = text.toUpperCase();
              textFieldBloc.add(Changed(formattedText));
              callback?.call(formattedText);
            },
            onSubmitted: (text) {
              textFieldBloc.add(Submitted(text));
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

  bool isEnable() {
    bool enable = false;
    try {
      enable = (textFieldBloc.state.state() == TextStates.idle);
    } catch (exception) {
      debugPrint("******* enable error *******");
    }
    return enable;
  }

  void enable() {
    try {
      textFieldBloc.add(Enable());
    } catch (exception) {
      debugPrint("******* enable error *******");
    }
  }

  void disable() {
    try {
      textFieldBloc.add(Disable());
    } catch (exception) {
      debugPrint("******* disable error *******");
    }
  }
}
