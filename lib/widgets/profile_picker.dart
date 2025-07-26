import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePicker extends StatefulWidget {
  final String? initialImagePath;
  final Function(String?) onImageSelected;

  const ProfilePicturePicker({
    Key? key,
    this.initialImagePath,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<ProfilePicturePicker> createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _imagePath = image.path;
        });
        widget.onImageSelected(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _imagePath = null;
    });
    widget.onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Profile Picture',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: _imagePath != null
                  ? Image.file(
                      File(_imagePath!),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder();
                      },
                    )
                  : _buildPlaceholder(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_imagePath != null)
          TextButton.icon(
            onPressed: _removeImage,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Remove Photo'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
      ),
      child: Icon(
        Icons.add_a_photo,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}