import 'package:smart_argutes/google_login/sign_in_google.dart';
import 'package:smart_argutes/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class signUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading(); //delay of login process
              } else if (snapshot.hasData) {
                UserHelper.saveUser(snapshot.data); //user data save to database
                return HomePage(); //homepage
              } else {
                return SignUpWidget(); //login page
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250, right: 40, left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Copyrights",
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.copyright_outlined,
                    size: 15,
                    color: Colors.grey,
                  ),
                  Text(
                    "Argutes Smart Learning LLP.",
                  ),
                ],
              ),
            ),
          ),
          Center(heightFactor: 300, child: CircularProgressIndicator()),
        ],
      );
}
