import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SeleccionImagen extends StatefulWidget {
  const SeleccionImagen({super.key});

  @override
  State<SeleccionImagen> createState() => _SeleccionImagenState();
}

final storage = FirebaseStorage.instance;
String imagePath = '';
final storageRef = FirebaseStorage.instance.ref();

Future<void> uploadFile(imagePath) async {
  File file = File(imagePath);
  try {
    await storageRef.child('images/${file.path}').putFile(file);
  } on FirebaseException catch (e) {
    print(e);
  }
}

class _SeleccionImagenState extends State<SeleccionImagen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          (imagePath == '') ? Container() : Image.file(File(imagePath)),
          ElevatedButton(
            onPressed: () {
              final ImagePicker _picker = ImagePicker();
              _picker
                  .pickImage(source: ImageSource.gallery)
                  .then((value) => setState(() {
                        imagePath = value!.path;
                        uploadFile(imagePath);
                        Navigator.pop(context);
                      }));
            },
            child: Text("Seleccionar imagen"),
          )
        ]));
  }
}
