import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/register_module.dart';

import 'package:flutter_application_1/services/auth_service.dart';

import 'package:flutter_application_1/calendar.dart';
import 'package:flutter_application_1/sign_in.dart';

class AuthModule extends StatefulWidget {
  const AuthModule({Key? key}) : super(key: key);

  @override
  _AuthModuleState createState() => _AuthModuleState();
}

class _AuthModuleState extends State<AuthModule> {
  bool signIn = true;
  @override
  Widget build(BuildContext context) {
    // sign in page
    return Scaffold(
      body: Center(
        //input username and password
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              signIn ? SignInModule() : RegisterModule(),
              //register if you don't have an account
              signIn
                  ? TextButton(
                      child: const Text('Do not have an account? Register'),
                      onPressed: () {
                        setState(() {
                          signIn = false;
                        });
                      },
                    )
                  : TextButton(
                      child: const Text('Have an account? Sign In'),
                      onPressed: () {
                        setState(() {
                          signIn = true;
                        });
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
