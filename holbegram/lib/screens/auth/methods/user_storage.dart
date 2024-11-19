import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Uploads an image to Firebase Storage.
  ///
  /// Parameters:
  /// - [isPost]: A boolean indicating whether the upload is related to a post.
  /// - [childName]: The name of the child folder to store the image.
  /// - [file]: The image file data as a Uint8List.
  ///
  /// Returns the download URL of the uploaded image.
  Future<String> uploadImageToStorage(
    bool isPost,
    String childName,
    Uint8List file,
  ) async {
    try {
      // Create a reference to the storage location
      Reference ref = _storage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid);

      // If it's a post, generate a unique ID for the image
      if (isPost) {
        String id = const Uuid().v1();
        ref = ref.child(id);
      }

      // Start the upload
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Log or handle the error appropriately
      //print('Failed to upload image: $e');
      return '';
    }
  }
}
