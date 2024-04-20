import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscured = true;

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
          title: const Text("Register"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
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
              enableInteractiveSelection: false,
              obscureText: _obscured,
              enableSuggestions: false,
              autocorrect: false,
              controller: _password,
              decoration: InputDecoration(
                  filled: true,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: GestureDetector(
                    onLongPressStart: (_){
                    setState(() {
                      _obscured = false;
                    });
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        _obscured = true;
                      });
                      },
                    child: Icon(
                      _obscured ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
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
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil('/verify/', (route) => false);
                }
                on FirebaseAuthException catch (e){
                  if (e.code == 'invalid-email') {
                    Fluttertoast.showToast(msg: "This isn't an Email!");
                  }
                  else if(e.code == 'email-already-in-use') {
                    Fluttertoast.showToast(msg: "Email already in use!!");
                  }
                  else if(e.code == 'weak-password') {
                    Fluttertoast.showToast(msg: "Choose a stronger password!");
                  }
                };
                },
              child: const Text("Register"),
            ),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
                  },
                child: const Text("Already registered? Login here!"),
            )
          ],
        ),
      ),
    );
  }
}