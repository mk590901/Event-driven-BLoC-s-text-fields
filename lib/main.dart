import 'package:flutter/material.dart';
import 'ui/widgets/custom_text.dart';
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

    CustomText text = CustomText(
        initText: 'start',
        hintText: 'Enter your text here...',
        labelText: 'Account Name',
        capitalization: TextCapitalization.words,
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
      canvasColor: Colors.blueAccent,
      canvasDisabledColor: Colors.blueGrey,
      canvasPressedColor: Colors.indigo,
      textColor: Colors.limeAccent,
      textDisabledColor: Colors.white70,
      textPressedColor: Colors.white,
      text: 'Enable/Disable',
      textPressed: 'Enable/Disable',
      textDisabled: 'Out of order',
      borderColor: Colors.limeAccent,
      borderPressedColor: Colors.white30,
      borderDisabledColor: Colors.blueGrey,
      borderWidth: 0.5,
      borderRadius: 8,
      onUpAction: () {
        //purple.enable();
        //blueRoundedAdvanced.click();
      },
      onDownAction: () {
        if (text.isEnabled()) {
          text.disable();
        } else {
          text.enable();
        }
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
            const SizedBox(height: 32,),
            textRoundedButton,
            //evaluatedButton,
          ],
        ),
      ),
    );
  }
}
