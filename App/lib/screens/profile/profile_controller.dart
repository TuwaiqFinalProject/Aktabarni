import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {
  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFilee =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFilee != null) {
      _image = XFile(pickedFilee.path);
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.camera,
                    ),
                    title: const Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.image,
                    ),
                    title: const Text('Gallery'),
                  )
                ],
              ),
            ),
          );
        });
  }
}