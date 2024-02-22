import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:notes/Views/register_view.dart';
import 'package:notes/Views/verify_view.dart';
import 'package:notes/Views/login_view.dart';
import 'package:notes/Views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final defaultLightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  runApp(
      DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme){
        return MaterialApp(
          theme: ThemeData(
            colorScheme: darkColorScheme ?? defaultLightColorScheme,
            useMaterial3: true,
          ),
          home:  const LoginView(),
          routes: {
            '/register/': (context) => const RegisterView(),
            '/verify/': (context) => const VerfiyEmailView(),
            '/login/': (context) => const LoginView(),
            '/home/': (context) => const HomePage(),
          },
        );
      }
      )
  );
}
















