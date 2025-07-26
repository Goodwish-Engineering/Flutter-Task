import 'package:image_picker/image_picker.dart';

class StudentRegistrationRepository {
    final ImagePicker _imagePicker = ImagePicker();
 Future<String?> imagePicker(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(source: source);
      if (image != null) return image.path;
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
