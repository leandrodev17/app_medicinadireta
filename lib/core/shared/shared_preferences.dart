import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String prefAuth = "@auth";
  static const String prefToken = "@token";
  static const String prefExpiresToken = "@expiresAt";
  static const String prefUserId = "@prefUserId";
  static const String prefTokenNotification = "@prefTokenNotification";
  static const String prefAccesAplication = "@prefAccesAplication";
  static const String prefNameUser = "@prefNameUser";
  static const String tokenInfoMed = "@tokenInfoMed";

  //################################
  // DADOS DE LOGIN
  //################################
  Future<String?> get currentTokenInfoMed => _getString(tokenInfoMed);
  Future setCurrentTokenInfoMed(String data) => _setString(tokenInfoMed, data);
  Future removeKeyTokenInfoMed() => _removeString(tokenInfoMed);

  Future<String?> get currentTokenNotification => _getString(prefTokenNotification);
  Future setCurrentTokenNotification(String data) => _setString(prefTokenNotification, data);
  Future removeKeyCurrentTokenNotification() => _removeString(prefTokenNotification);

  Future<int?> get userId => _getInt(prefUserId);
  Future setUserId(int data) => _setInt(prefUserId, data);
  Future removeKeyUserId() => _removeString(prefUserId);

  Future<String?> get currentExpiresToken => _getString(prefExpiresToken);
  Future setCurrentExpiresToken(String data) => _setString(prefExpiresToken, data);
  Future removeKeyCurrentExpiresToken() => _removeString(prefExpiresToken);

  Future<String?> get getNameUser => _getString(prefNameUser);
  Future setNameUser(String data) => _setString(prefNameUser, data);
  Future removeKeyNameUser() => _removeString(prefNameUser);

  Future<String?> get currentToken => _getString(prefToken);
  Future setCurrentToken(String data) => _setString(prefToken, data);
  Future removeKeyCurrentToken() => _removeString(prefToken);

  Future setCurrentAccess(String data) => _setString(prefAuth, data);
  Future<String?> get getDataCurrentAccess  =>  _getString(prefAuth);
  Future removeKeyCurrentAccess() => _removeString(prefAuth);

  Future setCurrentAccessAplication(String data) => _setString(prefAccesAplication, data);
  Future<String?> get getCurrentAccessAplication => _getString(prefAccesAplication);
  Future removeKeyCurrentAccessAplication() => _removeString(prefAccesAplication);

  Future<bool> removeAll() => _removeAll();
  // _setObject(String key, dynamic data) => SharedPreferences.getInstance().then((preference) => preference.setString(key, json.encode(data)));
  // _getObject(String key) => SharedPreferences.getInstance().then((preference) => json.decode(preference.getString(key) ?? ''));
  _setString(String key, String data) => SharedPreferences.getInstance().then((preference) => preference.setString(key, data));
  _getString(String key) => SharedPreferences.getInstance().then((preference) => preference.getString(key));
  _setInt(String key, int data) => SharedPreferences.getInstance().then((preference) => preference.setInt(key, data));
  _getInt(String key) => SharedPreferences.getInstance().then((preference) => preference.getInt(key));
  _removeString(String key) => SharedPreferences.getInstance().then((preference) => preference.remove(key));
  _removeAll() => SharedPreferences.getInstance().then((preference) => preference.clear());
}
