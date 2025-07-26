import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/hive/student.dart';

Future<void> initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(StudentAdapter());
  }
}
