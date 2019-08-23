import 'dart:async';
import 'package:flutter/material.dart';

import 'package:plant_life/screens/add.dart';
import 'package:plant_life/screens/calendar.dart';
import 'package:plant_life/screens/details.dart';
import 'package:plant_life/screens/home.dart';
import 'package:plant_life/screens/sign_in.dart';
import 'package:plant_life/services/auth.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(PlantApp());

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      builder: (_) => FirebaseAuthService(),
      dispose: (_, AuthService authService) => authService.dispose(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Life',
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/details': (context) => PlantDetails(null),
        '/calendar': (context) => CalendarPage(),
        '/add': (context) => PlantAddPage(''),
      },
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = Provider.of<AuthService>(context);
    return StreamBuilder<User>(
      stream: firebaseAuth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return HomePage();
        } else {
          // Add something for loading
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
