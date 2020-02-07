import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

abstract class AppMethods {
    Future<String> loginUser({ String email, String password });
    Future<String> createUserAccount({ String fullName, String phoneNumber, String email, String password });
    Future<bool> logoutUser();
    Future<DocumentSnapshot> getUserInfo(String userId);
    Future<String> addNewProduct({ Map newProduct });
    Future<List<String>> uploadProductImages({ List<File> iOsImages, String docID });
    Future<bool> updateProductImages({ String docID, List<String> data });
}