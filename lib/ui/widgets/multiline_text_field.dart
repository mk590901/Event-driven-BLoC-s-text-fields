import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/callback_fun_type.dart';
import '../../../ui/events/text_events.dart';
import '../../../ui/blocs/text_bloc.dart';
import '../../../ui/states/text_state.dart';

class MultilineTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late TextBloc textBloc;
  late Timer? timer;
  late String entity = '';

  final VoidCallbackParameter? onStartedAction;
  final VoidCallbackParameter? onChangedAction;
  final String initText;
  final String hintText;
  final String labelText;
  final Color textColorDisabled;
  final Color textColorEnabled;
  final TextCapitalization capitalization;
  final TextAlign align;

  void startTimer(final String text) {
    timer = Timer(const Duration(milliseconds: 100), () {
      onStartedAction?.call(text);
      timer?.cancel();
      timer = null;
    });
  }

  MultilineTextField(
      {super.key,
      this.align = TextAlign.start,
      this.initText = '',
      this.hintText = '',
      this.labelText = '',
      this.textColorEnabled = Colors.black,
      this.textColorDisabled = Colors.grey,
      this.capitalization = TextCapitalization.none,
      this.onStartedAction,
      this.onChangedAction});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        textBloc = TextBloc(TextState(TextStates.ready));
        if (initText.isNotEmpty) {
          textBloc.add(Changed(initText));
          entity = initText;
        }
        startTimer(initText);
        return textBloc;
      },
      child: BlocBuilder<TextBloc, TextState>(
        builder: (context, state) {
          _controller.value = _controller.value.copyWith(
            text: state.data(),
            selection: TextSelection.collapsed(
                offset:
                    state.data() != null ? (state.data() as String).length : 0),
          );

          return TextField(
            controller: _controller,
            focusNode: _focusNode,
            textCapitalization: capitalization,
            maxLines: null,
            // Makes the TextField multiline
            enabled: (state.state() == TextStates.ready),
            onChanged: (text) {
              entity = text;
              textBloc.add(Changed(text));
              onChangedAction?.call(text);
            },
            style: TextStyle(
                color: state.state() == TextStates.disabled
                    ? textColorDisabled
                    : textColorEnabled),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textColorEnabled, width: 2.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textColorDisabled, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textColorEnabled, width: 2.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                  color: state.state() == TextStates.disabled
                      ? textColorDisabled
                      : textColorEnabled),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: state.state() == TextStates.disabled
                      ? textColorDisabled
                      : textColorEnabled),
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

  bool isNotEmpty() {
    return entity.isNotEmpty;
  }

  String? text() {
    return entity;
  }
}
