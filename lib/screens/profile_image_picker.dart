import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final String? imageUrl;
  final Function(File) onImageSelected;

  const ProfileImagePicker({
    super.key,
    this.imageUrl,
    required this.onImageSelected,
  });

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getImage,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[300],
        backgroundImage: _getBackgroundImage(),
        child: _buildOverlay(),
      ),
    );
  }

  ImageProvider? _getBackgroundImage() {
    if (_image != null) {
      return FileImage(_image!);
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return NetworkImage(widget.imageUrl!);
    }
    return null;
  }

  Widget _buildOverlay() {
    if (_image == null &&
        (widget.imageUrl == null || widget.imageUrl!.isEmpty)) {
      return Icon(
        Icons.add_a_photo,
        size: 40,
        color: Colors.grey[800],
      );
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.3),
      ),
      child: const Icon(
        Icons.add_a_photo,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
