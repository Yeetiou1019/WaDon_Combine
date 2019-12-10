import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

StorageUploadTask uploadImage(File image, String account) {
  final extension = p.extension(image.path);
  final StorageReference ref =
      FirebaseStorage(storageBucket: 'gs://wadone-8ae44.appspot.com')
          .ref()
          .child('$account$extension');
  StorageUploadTask uploadTask = ref.putFile(image);
  return uploadTask;
}