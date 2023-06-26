import 'package:flutter/material.dart';

class CameraInputWidget extends StatefulWidget {
  const CameraInputWidget({super.key});

  @override
  State<CameraInputWidget> createState() => _CameraInputWidgetState();
}

class _CameraInputWidgetState extends State<CameraInputWidget> {
  void _openCamera() {}
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
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.camera),
        label: const Text('Take Picture'),
      ),
    );
  }
}
