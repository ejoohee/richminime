import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/screens/home_screen.dart';
import 'package:richminime/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  await Future.delayed(const Duration(seconds: 3));
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
        cardColor: const Color(0xffee6e9f),
        highlightColor: const Color.fromARGB(255, 235, 161, 190),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromARGB(255, 239, 206, 222),
          cardColor: const Color.fromARGB(255, 228, 136, 171),
          accentColor: const Color(0xffabbce7),
          errorColor: const Color.fromARGB(255, 98, 15, 198),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Stardust',
            wordSpacing: 5,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0, 0), // 그림자의 위치 (X, Y)
                blurRadius: 0.5, // 그림자의 흐림 정도
                color: Colors.black, // 그림자의 색상
              ),
            ],
            color: Color(0xFF6d9d88),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Stardust',
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Stardust',
            color: Color(0xFF6d9d88),
            fontSize: 18,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Stardust',
            color: Color(0xFF1a1a1a),
            fontSize: 17,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).cardColor.withOpacity(0.4),
            ),
          ),
        ),
      ),
      // home: const Login(),
      home: FutureBuilder<String?>(
        future: storage.read(key: "accessToken"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              return const HomeScreen();
            }
            return const Login();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
