import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  const User({@required this.uid});
}

abstract class AuthService {
  Future<User> signInWithGoogle();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}

class FirebaseAuthService implements AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if(user == null) {
      return null;
    } else {
      return User(uid: user.uid);
    }
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signInAnonymously() async {
    final AuthResult result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

     if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final AuthResult authResult = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }

  @override
  void dispose() {}


}
