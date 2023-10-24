import 'package:boilerplate/data/network/firebase/firebase_client.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGame {
  final FirebaseClient _firebaseClient;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseGame(this._firebaseClient);

  Future<Game?> getGame(String gameId) async {
    final document =
        await _firestore.collection(_firebaseClient.userId).doc(gameId).get();
    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      return Game.fromJson(gameId, data);
    }
    return null;
  }

  Future<void> saveGame(Game game) async {
    await _firestore
        .collection(_firebaseClient.userId)
        .doc(game.id)
        .set(game.toJson());
  }
}
