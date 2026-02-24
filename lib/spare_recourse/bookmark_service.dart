import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/anime_bookmark.dart';

class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Add bookmark (no duplicate)
  Future<void> addBookmark(AnimeBookmark anime) async {
    final uid = _auth.currentUser!.uid;

    final docRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .doc(anime.id);

    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set(anime.toMap());
    }
  }

  // ✅ Get all bookmarks
  Future<List<AnimeBookmark>> getBookmarks() async {
    final uid = _auth.currentUser!.uid;

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .get();

    return snapshot.docs
        .map((doc) =>
            AnimeBookmark.fromMap(doc.id, doc.data()))
        .toList();
  }

  // Stream Bookmarks (Realtime)
    Stream<List<AnimeBookmark>> streamBookmarks() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              AnimeBookmark.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}