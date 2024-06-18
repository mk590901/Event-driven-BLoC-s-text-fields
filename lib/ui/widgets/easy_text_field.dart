import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/callback_fun_type.dart';
import '../../../ui/events/text_events.dart';
import '../../../ui/blocs/text_bloc.dart';
import '../../../ui/states/text_state.dart';

class EasyTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late TextBloc textBloc;
  late Timer? timer;

  final VoidCallbackParameter? onStartedAction;
  final VoidCallbackParameter? onSubmittedAction;
  final VoidCallbackParameter? onChangedAction;
  final VoidCallbackParameter? onCompletedAction;
  final String initText;
  final String hintText;
  final bool obscureText;
  final Color textColorDisabled;
  final Color textColorEnabled;
  final TextCapitalization capitalization;

  //TextStyle defaultStyle = const TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);

  void startTimer(final String text) {
    timer = Timer(const Duration(milliseconds: 100), () {
      onStartedAction?.call(text);
      timer?.cancel();
      timer = null;
    });
  }

  EasyTextField({super.key, this.initText = '', this.hintText = '',
    this.textColorEnabled = Colors.black, this.textColorDisabled = Colors.grey,
    this.capitalization = TextCapitalization.none, this.obscureText = false,
    this.onStartedAction, this.onSubmittedAction, this.onChangedAction, this.onCompletedAction});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        textBloc = TextBloc(TextState(TextStates.ready));
        if (initText.isNotEmpty) {
          textBloc.add(Changed(initText));
        }
        startTimer(initText);
        return textBloc;
      },
      child: BlocBuilder<TextBloc, TextState>(
        builder: (context, state) {
            _controller.value = _controller.value.copyWith(
              text: state.data(),
              selection: TextSelection.collapsed(offset: state.data() != null ? (state.data() as String).length : 0),
            );

          return TextField(
            obscureText: obscureText,
            controller: _controller,
            focusNode: _focusNode,
            textCapitalization: capitalization,
            enabled: (state.state() == TextStates.ready),
            onChanged: (text) {
              textBloc.add(Changed(text));
              onChangedAction?.call(text);
            },
            onSubmitted: (text) {
              textBloc.add(Submitted(text));
              onSubmittedAction?.call(text);
            },
            onEditingComplete: () { //  ???
              debugPrint('Editing completed');
            },
            style: TextStyle(
                color: state.state() == TextStates.disabled ? textColorDisabled : textColorEnabled),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textColorEnabled, width: 2.0),
                borderRadius: BorderRadius.circular(32.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textColorDisabled, width: 2.0),
                borderRadius: BorderRadius.circular(32.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textColorEnabled, width: 2.0),
                borderRadius: BorderRadius.circular(32.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                  color: state.state() == TextStates.disabled ? textColorDisabled : textColorEnabled),
              labelStyle: TextStyle(
                  color: state.state() == TextStates.disabled ? textColorDisabled : textColorEnabled),
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

  bool isNotEmpty() {
    bool enable = false;
    bool notEmpty = false;
    try {
      enable = (textBloc.state.state() == TextStates.ready);
      if (enable) {
        String? result = textBloc.state.data();
        if (result != null) {
          notEmpty = result.isNotEmpty;
        }
      }
    } catch (exception) {
      debugPrint("******* isEnabled error: ${exception.toString()} *******");
    }
    return notEmpty;
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
