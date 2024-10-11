import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devcamp_ui/flutter_devcamp_ui.dart';
import 'package:flutter_devcamp_ui/screens/login_screen.dart';

class BoostrapApp extends StatelessWidget {
  BoostrapApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = _auth.currentUser;
            if (user == null) {
              return const LoginScreen();
            } else {
              return const FlutterDevCampUI();
            }
          }
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }
}
