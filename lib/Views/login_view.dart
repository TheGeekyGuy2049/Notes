import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscured = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  void _toggleObscured() {
    setState(
            () {
      _obscured = !_obscured;
    }
    );
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
                title: const Text("Login"),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              body: Padding(
                padding:  const EdgeInsets.all(20.0),
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
                      obscureText: _obscured,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _password,
                      decoration: InputDecoration(
                          filled: true,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(onPressed: ()=> _toggleObscured(), icon: _obscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
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
                          final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email,
                              password: password
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil('/main/', (route) => false);
                        }
                        on FirebaseAuthException catch (e){
                          if (e.code == 'invalid-credential') {
                            Fluttertoast.showToast(msg: "Make sure you typed your email and password correctly!");
                          }
                          else if(e.code == 'invalid-email') {
                            Fluttertoast.showToast(msg: "This isn't an Email!");
                          }
                        }
                        },
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
                        },
                      child: const Text("Not registered? Register here!"),
                    ),
                  ],
                ),
              ),
            );
        }
  }