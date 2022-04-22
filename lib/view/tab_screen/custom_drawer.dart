import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../about_author_screen/about_author_screen.dart';
import 'custom_drawer_constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _userAccountsDrawerHeader(
            userName: _user.displayName,
            userEmail: _user.email,
            userPhoto: _user.photoURL,
          ),
          ListTile(
            leading: const Icon(Icons.developer_mode),
            title: const Text(
              CustomDrawerConstants.aboutDeveloper,
            ),
            onTap: () async {
              await Navigator.push(
                  context, _routePage(const AboutAuthorScreen()));
            },
          ),
          _tileDivider(),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader _userAccountsDrawerHeader({
    @required userName,
    @required userEmail,
    @required userPhoto,
  }) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.blue, Colors.greenAccent],
        ),
      ),
      accountName: Text(
        userName!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      accountEmail: Text(
        userEmail!,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(userPhoto!),
        ),
      ),
    );
  }

  Divider _tileDivider() {
    return const Divider(
      height: 4,
      color: Colors.black38,
      indent: 20.0,
      endIndent: 20.0,
    );
  }

  Route _routePage(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => screen,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
