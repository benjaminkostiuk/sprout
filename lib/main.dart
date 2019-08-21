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

// class PlantApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Plant Life',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//         '/details': (context) => PlantDetails(null),
//         '/calendar': (context) => CalendarPage(),
//         '/add': (context) => PlantAddPage(''),
//       },
//     );
//   }
// }

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      builder: (_) => FirebaseAuthService(),
      dispose: (_, AuthService authService) => authService.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
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
          return HomePage2();
        } else {
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

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      try {
        final firebaseAuth = Provider.of<AuthService>(context);
        await firebaseAuth.signOut();
      } catch (e) {
        print(e); // TODO: show dialog with error
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
