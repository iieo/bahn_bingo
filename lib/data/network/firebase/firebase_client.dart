import 'package:bahn_bingo/data/sharedpref/shared_preference_helper.dart';
import 'package:uuid/uuid.dart';

class FirebaseClient {
  final SharedPreferenceHelper _sharedPreferenceHelper;

  FirebaseClient(this._sharedPreferenceHelper);

  String? _userId;

  Future<String> get userId async {
    if (_userId == null) {
      _userId = await getUserId();
    }
    return _userId!;
  }

  Future<String> getUserId() async {
    String? savedUserId = await _sharedPreferenceHelper.authToken;
    if (savedUserId == null) {
      savedUserId = generateUUID();
      await _sharedPreferenceHelper.saveAuthToken(savedUserId);
    }
    print("userID::" + savedUserId);
    return savedUserId;
  }

  String generateUUID() {
    Uuid uuid = Uuid();
    return uuid.v4();
  }
}
