import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
//import '../../../screens/auth/methods/user_storage.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to upload a post
  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      // Generate a unique postId
      String postId = const Uuid().v4();

      // Upload image to storage and get URL
      /*
      String postUrl = await StorageMethods().uploadImageToStorage(
        'posts', // Specify the folder for storing posts
        image, // Pass the image as Uint8List
        true, // Specify that it's a post
      );
      */
      // Create post data
      Map<String, dynamic> postData = {
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'postId': postId,
        'postUrl': randomPostUrl(),
        'datePublished': DateTime.now(),
        'likes': [], // Default empty likes list
      };

      // Add post to Firestore
      await _firestore.collection('posts').doc(postId).set(postData);

      return 'Ok';
    } catch (e) {
      // Return error message
      return e.toString();
    }
  }

  // Method to delete a post
  Future<void> deletePost(String postId) async {
    try {
      // Delete post from Firestore
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      debugPrint('Error deleting post: $e');
      rethrow; // Re-throw the error if needed
    }
  }
}

randomPostUrl() {
  String id = const Uuid().v4();
  return 'https://picsum.photos/seed/$id/200/300';
}
