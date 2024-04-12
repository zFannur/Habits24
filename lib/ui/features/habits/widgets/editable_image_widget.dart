import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class EditableImageWidget extends StatelessWidget {
  const EditableImageWidget({
    super.key,
    this.width = 95,
    this.height = 95,
    this.editable = false,
    required this.imagePath,
    this.onAdd,
    this.onDelete,
  });

  final double width;
  final double height;
  final bool editable;
  final String imagePath;
  final Function(String imagePath)? onAdd;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return imagePath.isNotEmpty
        ? _buildImageStack(context, imagePath)
        : _buildPlaceholderStack(context);
  }

  Widget _buildImageStack(BuildContext context, String imagePath) {
    return Stack(
      children: [
        Image.file(File(imagePath),
            width: width, height: height, fit: BoxFit.cover),
        if (editable) _buildDeleteButton(context),
      ],
    );
  }

  Widget _buildPlaceholderStack(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/loadImage.png',
            width: width, height: height, fit: BoxFit.cover),
        if (editable) _buildAddButton(context),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: IconButton(
        onPressed: () async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            final imageFile = File(pickedFile.path);
            final directory = await getApplicationDocumentsDirectory();
            final path = directory.path;
            final fileName = basename(imageFile.path);
            final savedImage = await imageFile.copy('$path/$fileName');
            onAdd?.call(savedImage.path);
          }
        },
        icon: AppIcons.editPhoto,
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: IconButton(
        onPressed: onDelete,
        icon: AppIcons.delete,
      ),
    );
  }
}
