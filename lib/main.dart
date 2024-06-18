import 'package:flutter/material.dart';
import 'ui/widgets/easy_text_field.dart';
import 'ui/widgets/multiline_text_field.dart';
import 'ui/widgets/flat_text_rounded_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextFieldPage(),
    );
  }
}

class TextFieldPage extends StatelessWidget {
  TextFieldPage({super.key});

  late FlatTextRoundedButton textRoundedButton;

  @override
  Widget build(BuildContext context) {

    final MultilineTextField text = MultilineTextField(
        hintText: 'Enter your text here...',
        labelText: 'Text',
        textColorEnabled: Colors.blue,
        capitalization: TextCapitalization.characters,
        onChangedAction: (text) {
          debugPrint('main.callbackChanged ->[$text]');
          if (text is String) {
            if ((text).isEmpty) {
              textRoundedButton.disable();
            }
            else {
              textRoundedButton.enable();
            }
          }
        },
//        (text) {}
    );

    textRoundedButton = FlatTextRoundedButton(
      width: 48,
      height: 14,
      canvasColor: Colors.transparent,
      canvasDisabledColor: Colors.blueGrey,
      canvasPressedColor: Colors.indigo,
      textColor: Colors.blue,
      textDisabledColor: Colors.white70,
      textPressedColor: Colors.white,
      text: 'Disable',
      textDisabled: 'Out of order',
      borderColor: Colors.blue,
      borderPressedColor: Colors.white30,
      borderDisabledColor: Colors.blueGrey,
      borderWidth: 0.5,
      borderRadius: 8,
      onDownAction: () {
        if (text.isEnabled()) {
          text.disable();
          textRoundedButton.changeText('Enable');
        } else {
          text.enable();
          textRoundedButton.changeText('Disable');
        }
      },
    );

    final EasyTextField password = EasyTextField(
      hintText: 'Enter password...',
      obscureText: true,
      textColorEnabled: Colors.blue,
      capitalization: TextCapitalization.characters,
      onChangedAction: (text) {
        debugPrint('password.onChangedAction ->[$text]');
        if (text is String) {
          if ((text).isEmpty) {
            textRoundedButton.disable();
          }
          else {
            textRoundedButton.enable();
          }
        }
      },
      onSubmittedAction: (text) {
        debugPrint('password.onSubmittedAction ->[$text]');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Custom TextField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            text,
            const SizedBox(height: 24,),
            textRoundedButton,
            const SizedBox(height: 32,),
            password,
            //evaluatedButton,
          ],
        ),
      ),
    );
  }
}
