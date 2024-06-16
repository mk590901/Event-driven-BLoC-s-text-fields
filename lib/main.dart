import 'package:flutter/material.dart';
import 'custom_text_field.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Custom TextField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //CustomTextField(),
            CustomTextField((text) {
              debugPrint('callback 1->[$text]');
            }),

            CustomTextField((text) {
              debugPrint('callback 2->[$text]');
            }),
          ],
        ),
      ),
    );
  }
}
