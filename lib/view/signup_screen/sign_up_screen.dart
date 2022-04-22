import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/view/signup_screen/sign_up_constants.dart';

import '../../service/impl/google_signin.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(SignUpConstants.title),
      ),
      body: _body(context: context),
    );
  }

  Widget _body({required BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              SignUpConstants.welcomeTitle,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Image(
              image: AssetImage(SignUpConstants.signUpImage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton.icon(
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.redAccent,
              ),
              label: const Text(
                SignUpConstants.signUpBtnText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1.5,
                  color: Colors.white10,
                ),
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Provider.of<GoogleSignInService>(context, listen: false)
                    .login();
              },
            ),
          ),
        ],
      ),
    );
  }
}
