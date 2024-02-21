import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:notes/Views/login_view.dart';
import 'package:notes/Views/register_view.dart';

import 'firebase_options.dart';

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
        );
      }
      )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home Page")),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user!.emailVerified){
                print("You are a verified user!");
              }
              else {
                print("You aren't a verified user. You need to verify your email first!");
              }
              return const Text("Done");
            default: return const Text("Loading...");
          }
        },
      ),
    );
  }
}












