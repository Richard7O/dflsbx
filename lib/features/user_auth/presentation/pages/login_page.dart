import 'package:dflsbx/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:dflsbx/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:dflsbx/features/user_auth/presentation/widgets/entry_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:dflsbx/features/user_auth/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Login',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, please login'),
              SizedBox(
                height: 30.0,
              ),
              EntryField(
                controller: emailController,
                hintText: 'Email',
                isPasswordField: false,
              ),
              SizedBox(
                height: 15.0,
              ),
              EntryField(
                controller: passwordController,
                hintText: 'Password',
                isPasswordField: true,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: signIn,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(elevation: 10.0),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    User? user = await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text);
    if (user != null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      }
    } else {
      if (mounted) {
        showAlertDialog(context);
      }
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invalid login credentials"),
      content: Text("The email address or password provided is incorrect"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}