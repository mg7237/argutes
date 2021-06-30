import 'package:smart_argutes/google_login/sign_in_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildSignUp(context);

  Widget buildSignUp(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 250, right: 110),
                child: Text(
                  'Argutes',
                  style: TextStyle(fontSize: 35),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 230,
              padding: EdgeInsets.all(4),
              child: ElevatedButton(
                child: Text(
                  'Google Sign In',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.yellow),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.login();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
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
          ],
        ),
      );
}
