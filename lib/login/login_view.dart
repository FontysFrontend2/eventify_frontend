import 'package:eventify_frontend/apis/controllers/login_controller.dart';
import 'package:eventify_frontend/login/registeration_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Eventify'),
        ),
        body: Container(
          color: Colors.blueGrey,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const Text(
              'Email:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              autofocus: false,
              textAlign: TextAlign.center,
              controller: emailCtrl,
              autocorrect: false,
            ),
            const Text(
              'Password:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              autofocus: false,
              textAlign: TextAlign.center,
              controller: passwdCtrl,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            ElevatedButton(
              onPressed: () {
                loginUser(emailCtrl.text, passwdCtrl.text);
              },
              child: const Text('Submit'),
            ),
            const Spacer(),
            const Text("Don't have an account?"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterationView();
                  }));
                },
                child: const Text('Register')),
          ]),
        ));
  }
}
