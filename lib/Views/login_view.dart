import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Center(child: Text("Login")),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          hintText: "Email"
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _password,
                      decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                          labelText: "Password",
                          hintText: "Password"
                      ),
                    ),
                    const SizedBox(height: 15),
                    FilledButton(
                      onPressed: () async{
                        final email = _email.text;
                        final password = _password.text;
                        try{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email,
                              password: password
                          );
                        }
                        on FirebaseAuthException catch (e){
                          if (e.code == 'invalid-credential') {
                            Fluttertoast.showToast(msg: "User not found!");
                          }
                          else if(e.code == 'invalid-email') {
                            Fluttertoast.showToast(msg: "This isn't an Email!");
                          }
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              );
            default: return const Text("Loading...");
          }
        },
      ),
    );
  }
}