import 'package:complex_ui/data/local/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    return _signIn(credential);
  }

  Future<FirebaseUser> _signIn(credential) async {
    final result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  User _userFromFirebase(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
            avatar: user.photoUrl,
          )
        : null;
  }

  Stream<User> get authUser {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<FirebaseUser> getCurrentUser() async {
    return _auth.currentUser();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future signOut() async {
    if (await isSignedIn()) {
      await _auth.signOut();
      await _googleSignIn.signOut();
    }
  }
}
