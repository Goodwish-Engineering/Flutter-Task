import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ImageStorage {
  static const _boxName = 'imageBox';
  static const _imageKey = 'profileImage';

  static Future<String> saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.png';
    final newImage = await image.copy('${directory.path}/$fileName');

    final box = await Hive.openBox<String>(_boxName);
    await box.put(_imageKey, newImage.path);

    return newImage.path;
  }

  static Future<String?> getImagePath() async {
    final box = await Hive.openBox<String>(_boxName);
    return box.get(_imageKey);
  }

  static Future<void> deleteImage() async {
    final box = await Hive.openBox<String>(_boxName);
    final path = box.get(_imageKey);
    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
      await box.delete(_imageKey);
    }
  }
}
