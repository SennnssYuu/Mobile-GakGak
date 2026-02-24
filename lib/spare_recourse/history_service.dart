import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/anime_history.dart';

class HistoryService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addToHistory(AnimeHistory anime) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('history')
        .doc(anime.id)
        .set(anime.toMap());
  }

  Future<List<AnimeHistory>> getHistory() async {
  final uid = _auth.currentUser!.uid;

  final snapshot = await _firestore
      .collection('users')
      .doc(uid)
      .collection('history')
      .orderBy('watchedAt', descending: true)
      .get();

  return snapshot.docs
      .map((doc) => AnimeHistory.fromMap(doc.id, doc.data()))
      .toList();
}

  Stream<List<AnimeHistory>> streamHistory() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('history')
        .orderBy('watchedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              AnimeHistory.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}