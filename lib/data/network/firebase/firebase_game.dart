import 'package:boilerplate/data/network/firebase/firebase_client.dart';
import 'package:boilerplate/domain/entity/game/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGame {
  final FirebaseClient _firebaseClient;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseGame(this._firebaseClient);

  Future<Game?> getGame(String gameId) async {
    print("GET <<< $gameId");

    final document = await _firestore
        .collection("userdata")
        .doc(await _firebaseClient.userId)
        .collection("games")
        .doc(gameId)
        .get();

    return await getGameFromDocument(document);
  }

  Future<Game?> getGameFromDocument(DocumentSnapshot document) async {
    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      data["id"] = document.id;
      return Game.fromJson(data);
    } else {
      print("Game ${document.id} does not exist");
    }
    return null;
  }

  Future<bool> createGame(Game game) async {
    print("CREATE >>> ${game.id}");

    try {
      Map<String, dynamic> data = game.toJson();
      data["finished"] = false;
      await _firestore.collection("games").doc(game.id).set(data);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> isGameFinished(String gameId) {
    return _firestore
        .collection("games")
        .doc(gameId)
        .get()
        .then((value) => value.data()?["finished"] ?? false);
  }

  Future<String> getGameWinner(String gameId) {
    return _firestore
        .collection("games")
        .doc(gameId)
        .get()
        .then((value) => value.data()?["winner"] ?? "error: no winner");
  }

  Future<bool> callBingo(String gameId, bool hasBingo) async {
    print("BINGO >>> ${gameId}");

    try {
      await _firestore.collection("games").doc(gameId).update(
          {"finished": hasBingo, "winner": await _firebaseClient.userId});
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> deleteGame(Game game) async {
    print("DELETE >>> ${game.id}");

    try {
      await _firestore.collection("games").doc(game.id).delete();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<Game?> joinGame(String gameId) async {
    print("JOIN <<< ${gameId}");

    final document = await _firestore.collection("games").doc(gameId).get();
    return getGameFromDocument(document);
  }

  Future<bool> saveGame(Game game) async {
    print("SAVE >>> ${game.id}");

    try {
      await _firestore
          .collection("userdata")
          .doc(await _firebaseClient.userId)
          .collection("games")
          .doc(game.id)
          .set(game.toJson());
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
