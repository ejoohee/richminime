import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // 패키지 임포트
import 'package:richminime/screens/bankbook.dart';
import 'package:richminime/screens/home_screen.dart'; // HomeScreen 임포트
import 'package:richminime/screens/login.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  final storage = const FlutterSecureStorage(); // SecureStorage 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // 기존 테마 설정
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
      home: const HomeScreen(),
      // home: FutureBuilder<String?>(
      //   // FutureBuilder를 사용하여 SecureStorage에서 토큰을 읽어옵니다.
      //   future: storage.read(key: "accessToken"),
      //   builder: (context, snapshot) {
      //     // 토큰이 있는 경우
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasData && snapshot.data != null) {
      //         return const BankBook(); // HomeScreen으로 이동
      //       }
      //       // 토큰이 없는 경우
      //       return const Login(); // Login 화면으로 이동
      //     }
      //     // 토큰을 읽어오는 동안 로딩 인디케이터를 표시합니다.
      //     return const CircularProgressIndicator();
      //   },
      // ),
    );
  }
}
