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
          home:  const HomePage(),
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
              // final user = FirebaseAuth.instance.currentUser;
              // if (user?.emailVerified ?? false){
              //   return const Text("Done");
              // }
              // else {
              //   return const VerfiyEmailView();
              // }
              return const LoginView();
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}

class VerfiyEmailView extends StatefulWidget {
  const VerfiyEmailView({super.key});

  @override
  State<VerfiyEmailView> createState() => _VerfiyEmailViewState();
}

class _VerfiyEmailViewState extends State<VerfiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "Please verify your email: ",
            style: TextStyle(
                fontSize: 25
            ),
          ),
        ),
        const SizedBox(height: 15),
        FilledButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send Email Verification"),
        )
      ],
    );
  }
}














