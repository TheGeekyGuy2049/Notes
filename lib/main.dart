import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:notes/Views/register_view.dart';
import 'package:notes/Views/verify_view.dart';
import 'package:notes/Views/login_view.dart';
import 'package:notes/Views/home_view.dart';
import 'Views/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme){
        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          home:  const HomePage(),
          routes: {
            '/register/': (context) => const RegisterView(),
            '/verify/': (context) => const VerfiyEmailView(),
            '/login/': (context) => const LoginView(),
            '/home/': (context) => const HomePage(),
            '/main/': (context) => const MainPage(),
          },
        );
      }
      ),
  );
}



















