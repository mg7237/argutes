import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  final String subject;
  final int cost;
  Purchase({required this.subject, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Subject: $subject'),
              Text('cost: $cost/-'),
            ],
          )
        ],
      ),
    );
  }
}
