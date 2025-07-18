import 'package:hive/hive.dart';

class HiveService {
  static Future<void> init() async {
    // Hive initialization is handled in main.dart
    // Hive.init('your_path');
  }

  Future<Box> openBox(String name) async {
    return await Hive.openBox(name);
  }

  Future<void> put(String boxName, String key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  Future<dynamic> get(String boxName, String key) async {
    final box = await openBox(boxName);
    return box.get(key);
  }
}
