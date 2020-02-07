import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:shoppingapp/tools/app_methods.dart';
import 'package:shoppingapp/tools/app_data.dart';
import 'package:shoppingapp/tools/app_tools.dart';

class FirebaseMethods implements AppMethods {
    Firestore firestore = Firestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    @override
    Future<String> createUserAccount({ String fullName, String phoneNumber, String email, String password }) async {
        AuthResult authResult;

        try {
            authResult = await firebaseAuth.createUserWithEmailAndPassword(
                email: email,
                password: password
            );

            if (authResult != null) {
                await firestore
                    .collection(usersData)
                    .document(authResult.user.uid)
                    .setData({
                        userID: authResult.user.uid,
                        userFullName: fullName,
                        userEmail: email,
                        userPassword: password,
                        userPhoneNumber: phoneNumber
                    });

                await writeDataLocally(key: userID, value: authResult.user.uid);
                await writeDataLocally(key: userFullName, value: fullName);
                await writeDataLocally(key: userEmail, value: email);
                await writeDataLocally(key: userPhoneNumber, value: phoneNumber);
                await writeBoolDataLocally(key: userLoggedIn, value: true); 
            }
        } on PlatformException catch (e) {
            return errorMSG(e.message);
        }

        return authResult == null ? errorMSG('Error') : successfulMSG();
    }

    @override
    Future<String> loginUser({String email, String password}) async {
        AuthResult authResult;

        try {
            authResult = await firebaseAuth.signInWithEmailAndPassword(
                email: email,
                password: password
            );

            if (authResult != null) {
                DocumentSnapshot documentSnapshot = await getUserInfo(authResult.user.uid);

                await writeDataLocally(key: userID, value: documentSnapshot[userID]);
                await writeDataLocally(key: userFullName, value: documentSnapshot[userFullName]);
                await writeDataLocally(key: userEmail, value: documentSnapshot[userEmail]);
                await writeDataLocally(key: userPhoneNumber, value: documentSnapshot[userPhoneNumber]);
                await writeDataLocally(key: userPhotoURL, value: documentSnapshot[userPhotoURL]);
                await writeBoolDataLocally(key: userLoggedIn, value: true);
            }
        } on PlatformException catch (e) {
            return errorMSG(e.message);
        }

        return authResult == null ? errorMSG('Error') : successfulMSG();
    }

    Future<bool> complete() async {
        return true;
    }

    Future<bool> notComplete() async {
        return false;
    }

    Future<String> successfulMSG() async {
        return successful;
    }

    Future<String> errorMSG(String e) async {
        return e;
    }

    @override
    Future<bool> logoutUser() async {
        await firebaseAuth.signOut();
        await clearDataLocally();
        return complete();
    }

    @override
    Future<DocumentSnapshot> getUserInfo(String userId) async {
        return await firestore.collection(usersData).document(userId).get();
    }

    @override
    Future<String> addNewProduct({ Map newProduct }) async {
        String documentID;

        var documentRef = await firestore.collection(appProducts).add(newProduct);

        documentID = documentRef.documentID;

        return documentID;
    }

    @override
    Future<List<String>> uploadProductImages({ List<File> iOsImages, String docID }) async {
        List<String> imageUrls = new List();
        try {
            for (int i = 0; i < iOsImages.length; i++) {
                StorageReference storageReference = FirebaseStorage.instance.ref().child(appProducts).child(docID).child(docID + '$i.jpg');
                StorageUploadTask uploadTask = storageReference.putFile(iOsImages[i]);
                StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                String downloadUrl = await taskSnapshot.ref.getDownloadURL();
                imageUrls.add(downloadUrl);
            }
        } on PlatformException catch (e) {
            imageUrls.add(error);
            print(e.details);
        }
        return imageUrls;
    }

    @override
    Future<bool> updateProductImages({String docID, List<String> data}) async {
        bool msg;
        await firestore.collection(appProducts).document(docID).updateData({
            productImages: data
        }).whenComplete(() {
            msg = true;
        });
        return msg;
    }
}