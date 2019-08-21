import 'package:flutter/material.dart';
import 'package:plant_life/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _signInAnonymously() async {
      try {
        final firebaseAuth = Provider.of<AuthService>(context);
        await firebaseAuth.signInAnonymously();
      } catch (e) {
        print(e); // TODO: show dialog with error
      }
    }

    Future<void> _googleSignIn() async {
      try {
        final firebaseAuth = Provider.of<AuthService>(context);
        await firebaseAuth.signInWithGoogle();
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: Text(
                      'Plant Life',
                      style: TextStyle(color: Colors.pink, fontSize: 50.0),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Sign in with google'),
                    onPressed: _googleSignIn,
                  ),
                  RaisedButton(
                    child: Text('Sign in anonymously'),
                    onPressed: _signInAnonymously,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50.0),
              child: Image.asset(
                'assets/login_plant.jpg',
                fit: BoxFit.contain,
                scale: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
