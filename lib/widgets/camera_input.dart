import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraInputWidget extends StatefulWidget {
  const CameraInputWidget({super.key});

  @override
  State<CameraInputWidget> createState() => _CameraInputWidgetState();
}

class _CameraInputWidgetState extends State<CameraInputWidget> {
  File? _takenImage;

  void _openCamera() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (takenImage == null) {
      return;
    }
    setState(() {
      _takenImage = File(takenImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      // Image preview or button
      child: _takenImage == null
          ? TextButton.icon(
              onPressed: _openCamera,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
            )
          : GestureDetector(
            onTap: _openCamera,
            child: Image.file(
                _takenImage!,
                fit: BoxFit.cover,
              ),
          ),
    );
  }
}
