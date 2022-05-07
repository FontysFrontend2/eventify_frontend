import 'package:eventify_frontend/apis/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class RegisterationView extends StatefulWidget {
  const RegisterationView({Key? key}) : super(key: key);

  @override
  State<RegisterationView> createState() => _RegisterationViewState();
}

class _RegisterationViewState extends State<RegisterationView> {
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
        color: Colors.grey,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const Text(
            'Username:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            autofocus: false,
            textAlign: TextAlign.center,
            controller: usernameCtrl,
            autocorrect: false,
          ),
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
              registerUser(usernameCtrl.text, emailCtrl.text, passwdCtrl.text);
            },
            child: const Text('Submit'),
          ),
        ]),
      ),
    );
  }
}
