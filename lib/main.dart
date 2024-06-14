import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/text_field_bloc.dart';
import 'bloc/text_field_event.dart';
import 'bloc/text_field_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TextFieldBloc(),
        child: TextFieldPage(),
      ),
    );
  }
}

class TextFieldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextFieldBloc textFieldBloc = BlocProvider.of<TextFieldBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC TextField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<TextFieldBloc, TextFieldState>(
              builder: (context, state) {
                String displayText = '';
                if (state is TextFieldChanged) {
                  displayText = state.text;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      maxLines: null,
                      onChanged: (text) {
                        textFieldBloc.add(TextChanged(text));
                      },
                      onSubmitted: (text) {
                        debugPrint('submitted: $text');
                        textFieldBloc.add(TextSubmitted(text));
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your text here...',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Text: $displayText'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
