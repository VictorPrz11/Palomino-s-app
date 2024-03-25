import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  Future<DocumentReference> addPlatillo(
      String nombre, String precio, String descripcion, String categoria) {
    if (!_loggedIn) {
      throw Exception('Debes iniciar sesión para agregar un platillo');
    }

    return FirebaseFirestore.instance
        .collection('platillos')
        .add(<String, dynamic>{
      'descripcion': descripcion,
      'nombre': nombre,
      'precio': precio,
      'categoria': categoria,
      'fecha': DateTime.now(),
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
