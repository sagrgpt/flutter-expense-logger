import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "No transactions added yet",
          style: Theme.of(context).textTheme.headline6,
        ),
        Container(
          height: 300,
          margin: EdgeInsets.only(top: 10),
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
