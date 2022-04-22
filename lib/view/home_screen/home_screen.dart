import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/view/tab_screen/tab_screen.dart';

import '../signup_screen/sign_up_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const errorMessage = 'Something went wrong';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const TabScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(errorMessage),
            );
          } else {
            return const SignUpScreen();
          }
        },
      ),
    );
  }
}
