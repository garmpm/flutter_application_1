import 'package:flutter/material.dart';
import 'package:flutter_application_1/state/my_app_state.dart';
import 'package:provider/provider.dart';

class CaesarPage extends StatefulWidget {
  const CaesarPage({super.key});

  @override
  State<CaesarPage> createState() => _CaesarPageState();
}

class _CaesarPageState extends State<CaesarPage> {
  final textControl = TextEditingController();
  var ciphertext = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: TextField(
            controller: textControl,
            decoration: InputDecoration(
                label: Text('Plaintext'),
                border: OutlineInputBorder(),
                hintText: 'Enter a plaintext'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            ciphertext = appState.encodeCaesar(textControl.text);
          },
          child: Text("ENCRYPT"),
        ),
        SizedBox(
          height: 30,
        ),
        Text('Ciphertext:'),
        Expanded(
          child: Text(
            ciphertext,
            style: theme.textTheme.displaySmall!,
          ),
        ),
      ],
    );
  }
}
