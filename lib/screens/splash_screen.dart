import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          "Loading App...",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}