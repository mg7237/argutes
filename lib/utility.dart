import 'package:flutter/material.dart';

bool returnTrue = true;
bool returnFalse = true;

enum ConfirmAction { CANCEL, OK }

class AlertDialogs {
  final String title;
  final String message;
  AlertDialogs({required this.title, required this.message});

  ///  asyncConfirmDialog used where user has option of OK / Cancel.
  ///  For example Do you wish to continue? Yes/No

  Future<void> asyncConfirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop('CANCEL');
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop('OK');
              },
            )
          ],
        );
      },
    );
  }

  ///  asyncAckAlert used where user can acknowledge the message.
  ///  For example Save was successful

  Future<void> asyncAckAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            this.title,
            style: TextStyle(fontSize: 18),
          ),
          content: Text(this.message, style: TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
