import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceProvider with ChangeNotifier {
  final SharedPreferences _prefs;

  PersistenceProvider(this._prefs);

  SharedPreferences get prefs => _prefs;
}
