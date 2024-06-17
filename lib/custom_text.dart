import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'callback_fun_type.dart';
import 'events/text_events.dart';
import 'state_machines/text_bloc.dart';
import 'states/text_state.dart';

class CustomText extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late TextBloc textBloc;

  final VoidCallbackParameter? callbackSubmitted;
  final VoidCallbackParameter? onChangedAction;
  final String initText;
  final String hintText;

  CustomText({super.key, this.initText = '', this.hintText = '', this.callbackSubmitted, this.onChangedAction});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        textBloc = TextBloc(TextState(TextStates.ready));
        if (initText.isNotEmpty) {
          textBloc.add(Changed(initText.toUpperCase()));
        }
        return textBloc;
      },
      child: BlocBuilder<TextBloc, TextState>(
        builder: (context, state) {
            _controller.value = _controller.value.copyWith(
              text: state.data(),
              selection: TextSelection.collapsed(offset: state.data() != null ? (state.data() as String).length : 0),
            );

          return TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: null,  // Makes the TextField multiline
            enabled: (state.state() == TextStates.ready),
            onChanged: (text) {
              // Example of formatting: capitalize every letter
              String formattedText = text.toUpperCase();
              textBloc.add(Changed(formattedText));
              onChangedAction?.call(formattedText);
            },
            onSubmitted: (text) {
              String formattedText = text.toUpperCase();
              textBloc.add(Submitted(formattedText));
              callbackSubmitted?.call(formattedText);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
          );
        },
      ),
    );
  }

  bool isEnabled() {
    bool enable = false;
    try {
      enable = (textBloc.state.state() == TextStates.ready);
    } catch (exception) {
      debugPrint("******* isEnabled error: ${exception.toString()} *******");
    }
    return enable;
  }

  void enable() {
    try {
      textBloc.add(Enable());
    } catch (exception) {
      debugPrint("******* enable error *******");
    }
  }

  void disable() {
    try {
      textBloc.add(Disable());
    } catch (exception) {
      debugPrint("******* disable error *******");
    }
  }

  String? text() {
    String? result;
    try {
      result = textBloc.state.data();
    } catch (exception) {
      debugPrint("******* disable error *******");
    }
    return result;
  }

}
