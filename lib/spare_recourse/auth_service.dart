import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user_service.dart';

class AuthService {

  Future<void> _ensureUserDocument(User user) async {
    final userService = UserService();

    final existingUser = await userService.getUser();

    if (existingUser == null) {
      await userService.createUser(
        name: user.displayName ?? "No Name",
        email: user.email ?? "",
      );
    }
  }

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

      final user = userCredential.user;

      if (user != null) {
        await _ensureUserDocument(user); // 🔥 added
      }

      return user;
    } catch (e) {
      print("Google sign in error: $e");
      rethrow;
    }
  }
  ///------------------ EMAIL SIGN IN ----------------
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await _ensureUserDocument(user); // ensure Firestore doc exists
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }
  ///----------------- EMAIL SIGN UP ----------------
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();

      await _ensureUserDocument(user);
    }

    return user;
  }

  /// ---------------- Github SIGN IN ----------------
  Future<User?> signInWithGithub() async {
    try {
      final githubProvider = GithubAuthProvider();

      final userCredential =
          await _auth.signInWithProvider(githubProvider);

      final user = userCredential.user;

      if (user != null) {
        await _ensureUserDocument(user); // 🔥 ensure Firestore user exists
      }

      return user;
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