import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await Hive.initFlutter();
  }

  // Shared Preferences Methods
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static Future<void> setDoubleList(String key, List<double> value) async {
    await _prefs.setStringList(key, value.map((e) => e.toString()).toList());
  }

  static List<double>? getDoubleList(String key) {
    final list = _prefs.getStringList(key);
    return list?.map((e) => double.parse(e)).toList();
  }

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  // Hive Methods for complex objects
  static Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  static Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }
}
