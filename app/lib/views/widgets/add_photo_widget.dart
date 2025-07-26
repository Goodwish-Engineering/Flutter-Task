import 'package:app/config/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPhotoWidget extends StatefulWidget {
  final void Function(File?)? onImagePicked;
  final File? initialImage;
  const AddPhotoWidget({super.key, this.onImagePicked, this.initialImage});

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    // Initialize with the provided initial image
    _pickedImage = widget.initialImage;
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _pickedImage = File(pickedFile.path);
        });
        // Notify parent about the new image
        if (widget.onImagePicked != null) {
          widget.onImagePicked!(_pickedImage);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          child:
              _pickedImage == null ? const Icon(Icons.person, size: 50) : null,
        ),
        Positioned(
          right: -5,
          bottom: -5,
          child: InkWell(
            onTap: pickImage,
            child: Container(
              decoration: BoxDecoration(
                color: AppPallete.gradient1,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.add, size: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
