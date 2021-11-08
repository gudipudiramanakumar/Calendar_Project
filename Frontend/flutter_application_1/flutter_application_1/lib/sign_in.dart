import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';

import 'package:flutter_application_1/calendar.dart';

class SignInModule extends StatefulWidget {
  const SignInModule({Key? key}) : super(key: key);

  @override
  _SignInModuleState createState() => _SignInModuleState();
}

class _SignInModuleState extends State<SignInModule> {
  final username = TextEditingController();
  final password = TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: username,
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            hintText: 'Username',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: authService.validateEmail,
        ),
        TextFormField(
          controller: password,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Sign in'),
            ),
            onPressed: () {
              var user = null;
              authService.signIn(username.text, password.text).then((value) {
                if (value == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Invalid username or password'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  user = value;
                  Navigator.pushReplacementNamed(context, '/calendar',
                      arguments: user);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
