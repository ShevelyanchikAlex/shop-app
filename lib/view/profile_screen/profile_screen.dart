import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser!;
    return Column(
      children: [
        Padding(
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(_user.photoURL!),
          ),
          padding: const EdgeInsets.all(25.0),
        ),
        Padding(
          child: Text(
            _user.displayName!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: const EdgeInsets.only(top: 25, bottom: 5.0),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            _user.email!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 23.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
