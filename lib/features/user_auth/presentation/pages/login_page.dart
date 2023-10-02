import 'package:dflsbx/features/user_auth/presentation/widgets/entry_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, please login'),
            SizedBox(
              height: 30.0,
            ),
            EntryField(
              hintText: 'Email',
              isPasswordField: false,
            ),
            SizedBox(
              height: 20.0,
            ),
            EntryField(
              hintText: 'Password',
              isPasswordField: true,
            ),
          ],
        ),
      ),
    );
  }
}