import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Register")),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: const InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _password,
                    decoration: const InputDecoration(
                        hintText: "Password"
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      final email = _email.text;
                      final password = _password.text;
                      try{
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password
                        );
                      }
                      on FirebaseAuthException catch (e){
                        print(e.code);
                        if (e.code == 'invalid-email') {
                          Fluttertoast.showToast(msg: "This isn't an Email!");
                        }
                        else if(e.code == 'email-already-in-use') {
                          Fluttertoast.showToast(msg: "Email already in use!!");
                        }
                        else if(e.code == 'weak-password') {
                          Fluttertoast.showToast(msg: "Choose a stronger password!");
                        }
                      }
                    },
                    child: const Text("Register"),
                  ),
                ],
              );
            default: return const Text("Loading...");
          }
        },
      ),
    );
  }
}