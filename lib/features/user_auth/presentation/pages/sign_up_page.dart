import 'package:dflsbx/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:dflsbx/features/user_auth/presentation/pages/home_page.dart';
import 'package:dflsbx/features/user_auth/presentation/pages/login_page.dart';
import 'package:dflsbx/features/user_auth/presentation/widgets/entry_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
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
          'Sign up',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, please sign up'),
              SizedBox(
                height: 30.0,
              ),
              EntryField(
                controller: usernameController,
                hintText: 'User name',
                isPasswordField: false,
              ),
              SizedBox(
                height: 15.0,
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
                onPressed: signUp,
                child: Text('Sign up'),
                style: ElevatedButton.styleFrom(elevation: 10.0),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Text(
                      'Login',
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

  void signUp() async {
    User? user = await _auth.signUpWithEmailAndPassword(emailController.text, passwordController.text);
    if (user != null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      }
    } else {
      print("Error handling");
    }
  }
}