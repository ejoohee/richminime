import 'package:flutter/material.dart';
import 'package:richminime/screens/bankbook.dart';
import 'package:richminime/screens/login.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFEEEBE3),
          cardColor: const Color(0xFFFFBEBE),
        ),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
          color: Color(0xFFEEb4a2),
        )),
      ),
      home: const BankBook(),
    );
  }
}
