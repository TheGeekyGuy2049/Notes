import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/Views/login_view.dart';
import 'package:notes/Views/main_view.dart';
import 'package:notes/Views/register_view.dart';
import 'package:notes/Views/verify_view.dart';
import '../firebase_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user !=null) {
              if (user.emailVerified) {
                return const MainPage();
              }
              else {
                return const VerfiyEmailView();
              }
            }
            else {
              return const LoginView();
            }
          default:
            return const Center(
                child: SizedBox(
                    child: CircularProgressIndicator()
                )
            );
        }
      },
    );
  }
}
