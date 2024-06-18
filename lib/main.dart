import 'package:flutter/material.dart';
import 'ui/widgets/easy_text_field.dart';
import 'ui/widgets/multiline_text_field.dart';
import 'ui/widgets/flat_text_rounded_button.dart';

void main() {
  runApp(const CustomTextFieldsDemoApp());
}

class CustomTextFieldsDemoApp extends StatelessWidget {
  const CustomTextFieldsDemoApp({super.key});

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
    final MultilineTextField multilineText = MultilineTextField(
      hintText: 'Enter your text here...',
      labelText: 'Text',
      textColorEnabled: Colors.blue,
      capitalization: TextCapitalization.characters,
      onChangedAction: (text) {
        debugPrint('main.onChangedAction ->[$text]');
        setupTextRoundedButton(text);
      },
      onStartedAction: (text) {
        debugPrint('main.callbackChanged ->[$text]');
        setupTextRoundedButton(text);
      },
    );

    textRoundedButton = FlatTextRoundedButton(
      width: 48,
      height: 12,
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
        if (multilineText.isEnabled()) {
          multilineText.disable();
          textRoundedButton.changeText('Enable');
        } else {
          multilineText.enable();
          textRoundedButton.changeText('Disable');
        }
      },
    );

    final FlatTextRoundedButton loginRoundedButton = FlatTextRoundedButton(
      width: 48,
      height: 12,
      canvasColor: Colors.blueAccent,
      canvasDisabledColor: Colors.blueGrey,
      canvasPressedColor: Colors.indigo,
      textColor: Colors.white,
      textDisabledColor: Colors.white70,
      textPressedColor: Colors.white,
      text: 'Login',
      textDisabled: 'Login',
      borderColor: Colors.blue,
      borderPressedColor: Colors.white30,
      borderDisabledColor: Colors.blueGrey,
      borderWidth: 0.5,
      borderRadius: 8,
      onDownAction: () {},
    );

    final EasyTextField password = EasyTextField(
      hintText: 'Enter password...',
      obscureText: true,
      textColorEnabled: Colors.black,
      capitalization: TextCapitalization.characters,
      onChangedAction: (text) {
        debugPrint('password.onChangedAction ->[$text]');
        setupRoundedButton(text.isNotEmpty, loginRoundedButton);
      },
      onSubmittedAction: (text) {
        debugPrint('password.onSubmittedAction ->[$text]');
      },
      onCompletedAction: (text) {
        debugPrint('password.onCompletedAction ->[$text]');
      },
      onStartedAction: (text) {
        debugPrint('password.onStartedAction ->[$text]');
      },
    );

    final EasyTextField account = EasyTextField(
      hintText: 'Enter account name...',
      textColorEnabled: Colors.black,
      onChangedAction: (text) {
        debugPrint(
            'account.onChangedAction ->[$text] ${text.isNotEmpty}, ${password.isNotEmpty()}');
        setupPassword(text, password);
        setupRoundedButton(
            text.isNotEmpty && password.isNotEmpty(), loginRoundedButton);
      },
      onSubmittedAction: (text) {
        debugPrint('account.onSubmittedAction ->[$text]');
      },
      onCompletedAction: (text) {
        debugPrint('account.onCompletedAction ->[$text]');
      },
      onStartedAction: (text) {
        debugPrint('account.onStartedAction ->[$text]');
        setupPassword(text, password);
        setupRoundedButton(
            text.isNotEmpty && password.isNotEmpty(), loginRoundedButton);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Text Fields',
            style: buildTitleTextStyle()),
        leading: IconButton(
          icon: const Icon(Icons.text_snippet_outlined, color: Colors.white),
          // Icon widget
          onPressed: () {
            // Add your onPressed logic here
          },
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              multilineText,
              const SizedBox(
                height: 24,
              ),
              textRoundedButton,
              const SizedBox(
                height: 16,
              ),

              const Divider(
                color: Colors.teal,
                thickness: 2,
              ),

              const SizedBox(
                height: 16,
              ),

              account,
              const SizedBox(
                height: 16,
              ),
              password,
              const SizedBox(
                height: 16,
              ),
              loginRoundedButton,
            ],
          ),
        ),
      ),
    );
  }

  void setupPassword(text, EasyTextField password) {
    if (text is String) {
      if ((text).isEmpty) {
        password.disable();
      } else {
        password.enable();
      }
    }
  }

  void setupTextRoundedButton(text) {
    if (text is String) {
      if ((text).isEmpty) {
        textRoundedButton.disable();
      } else {
        textRoundedButton.enable();
      }
    }
  }

  void setupRoundedButton(bool enable, FlatTextRoundedButton button) {
    if (!enable) {
      button.disable();
    } else {
      button.enable();
    }
  }

  TextStyle buildTitleTextStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontStyle: FontStyle.italic,
      shadows: [
        Shadow(
          blurRadius: 8.0,
          color: Colors.indigo,
          offset: Offset(3.0, 3.0),
        ),
      ],
    );
  }
}
