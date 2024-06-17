import 'package:flutter/material.dart';
import 'custom_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TextFieldPage(),
    );
  }
}

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {

    CustomText text = CustomText('start',(text){
      debugPrint('main.callbackChanged ->[$text]');
    }, (text) {});

    ElevatedButton evaluatedButton = ElevatedButton(
      onPressed: () {
        if (text.isEnabled()) {
          text.disable();
        }
        else {
          text.enable();
        }
      },
      child: Text(text.isEnabled() ? 'Disable' : 'Enable'),
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
            evaluatedButton,
          ],
        ),
      ),
    );
  }
}
