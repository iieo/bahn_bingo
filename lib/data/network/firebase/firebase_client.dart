import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:uuid/uuid.dart';

class FirebaseClient {
  final SharedPreferenceHelper _sharedPreferenceHelper;

  FirebaseClient(this._sharedPreferenceHelper) {
    getUserId();
  }

  late String _userId;

  String get userId => _userId;

  Future<void> getUserId() async {
    String? savedUserId = await _sharedPreferenceHelper.authToken;
    if (savedUserId == null) {
      savedUserId = generateUUID();
      await _sharedPreferenceHelper.saveAuthToken(savedUserId);
    }
    print(savedUserId);
  }

  String generateUUID() {
    Uuid uuid = Uuid();
    return uuid.v4();
  }
}
