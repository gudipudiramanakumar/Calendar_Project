import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';

import 'package:flutter_application_1/calendar.dart';

class RegisterModule extends StatefulWidget {
  const RegisterModule({Key? key}) : super(key: key);

  @override
  _RegisterModuleState createState() => _RegisterModuleState();
}

class _RegisterModuleState extends State<RegisterModule> {
  final username = TextEditingController();
  final password = TextEditingController();
  final password_confirmation = TextEditingController();

  final authService = AuthService();

  String? comparePasswords(String? value) {
    if (password.text != password_confirmation.text)
      return 'Passwords not matching';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: username,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Choose Username',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: authService.validateEmail,
        ),
        TextFormField(
          controller: password,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Choose Password',
          ),
          validator: authService.validatePassword,
        ),
        TextFormField(
          controller: password_confirmation,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Confirm Password',
          ),
          validator: comparePasswords,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Register'),
            ),
            onPressed: () {
              var user = null;
              authService.signUp(username.text, password.text).then((value) {
                if (value == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Registration unsuccessfull'),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Registration successfull'),
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
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
