import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// ---------------- GOOGLE SIGN IN ----------------
  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId:
            "688114842013-d5etn85jh5gp0ls1d6ab9o67qvjbsiss.apps.googleusercontent.com",
      );

      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Google sign in error: $e");
      rethrow;
    }
  }

  /// ---------------- Github SIGN IN ----------------
  Future<User?> signInWithGithub() async {
    try {

      final githubProvider = GithubAuthProvider();

      final userCredential =
          await FirebaseAuth.instance.signInWithProvider(githubProvider);

      return userCredential.user;
    } catch (e) {
      print("GitHub login error: $e");
      rethrow;
    } 
  }

  /// ---------------- SIGN OUT (ALL) ----------------
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}

    await _auth.signOut();
  }
}