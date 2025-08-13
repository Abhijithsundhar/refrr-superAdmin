import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickedImage {
  final Uint8List bytes;
  final String name;

  PickedImage({required this.bytes, required this.name});
}

class ImagePickerHelper {
  static Future<PickedImage?> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      return PickedImage(bytes: bytes, name: pickedFile.name);
    }
    return null;
  }

  static Future<String?> uploadImageToFirebase(PickedImage image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profiles/${DateTime.now().millisecondsSinceEpoch}_${image.name}');

      final uploadTask = await ref.putData(image.bytes);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}


