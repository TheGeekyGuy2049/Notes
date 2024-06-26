import 'package:flutter/material.dart';
import 'package:notes/Services/Auth/auth_service.dart';

class VerfiyEmailView extends StatefulWidget {
  const VerfiyEmailView({super.key});

  @override
  State<VerfiyEmailView> createState() => _VerfiyEmailViewState();
}

class _VerfiyEmailViewState extends State<VerfiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
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
              AuthService.firebase().sendEmailVerification();
              Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
              },
            child: const Text("Send Email Verification"),
          ),
        ],
      ),
    );
  }
}