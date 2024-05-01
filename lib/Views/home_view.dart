import 'package:flutter/material.dart';
import 'package:notes/Services/Auth/auth_service.dart';
import 'package:notes/Views/login_view.dart';
import 'package:notes/Views/notes_view.dart';
import 'package:notes/Views/verify_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user !=null) {
              if (user.isEmailVerified) {
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
