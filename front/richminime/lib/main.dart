import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/screens/bankbook.dart';
import 'package:richminime/screens/home_screen.dart';
import 'package:richminime/screens/login.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  assetsAudioPlayer.open(
    Audio("assets/audios/background.mp3"),
    loopMode: LoopMode.single,
    autoStart: true,
    showNotification: false,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  final storage = const FlutterSecureStorage(); // SecureStorage 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Dunggeunmo',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFEEEBE3),
          cardColor: const Color(0xFFFFBEBE),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFFEEb4a2),
          ),
        ),
      ),
      home: const Login(),
      // home: FutureBuilder<String?>(
      //   future: storage.read(key: "accessToken"),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasData && snapshot.data != null) {
      //         return const HomeScreen();
      //       }
      //       return const Login();
      //     }
      //     return const CircularProgressIndicator();
      //   },
      // ),
    );
  }
}
