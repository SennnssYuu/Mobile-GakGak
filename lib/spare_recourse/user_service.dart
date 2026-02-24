import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/users.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user UID
  String? get uid => _auth.currentUser?.uid;

  /// 🔹 Get User Data Once
  Future<AppUser?> getUser() async {
    if (uid == null) return null;

    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return AppUser.fromMap(doc.data()!);
  }

  /// 🔹 Get User as Stream (Realtime)
  Stream<AppUser?> streamUser() {
    if (uid == null) {
      return Stream.value(null);
    }

    return _db.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return AppUser.fromMap(doc.data()!);
    });
  }

  /// 🔹 Update User Name
  Future<void> updateName(String name) async {
    if (uid == null) return;

    await _db.collection('users').doc(uid).update({
      'name': name,
    });
  }

  /// 🔹 Update Setting Toggle
  Future<Map<String, dynamic>> getSettings() async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['setting'] ?? {};
  }
  
  Future<void> updateSetting(String field, bool value) async {
    await _db.collection('users').doc(uid).update({
      'setting.$field': value,
    });
  }

  // Update User Method
  Future<void> updateField(String field, dynamic value) async {
    if (uid == null) return;

    await _db.collection('users').doc(uid).update({
      field: value,
    });
  }

  /// 🔹 Create User Document (On Signup)
  Future<void> createUser({
    required String name,
    required String email,
  }) async {
    if (uid == null) return;

    await _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'birthday': '',
      'gender': '',
      'phone': '',
      'profil': '',
      'setting': {
        'AccountisEnabled': true,
        'NewAnimeisEnabled': true,
        'NewLoginisEnabled': true,
        'ReccomendationisEnabled': true,
        'SurveyisEnabled': true,
        'TwoFactorAuthisEnabled': true,
        'adultContentFilterisEnabled': true,
        'thirdPartyCookiesisEnabled': true,
      },
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}