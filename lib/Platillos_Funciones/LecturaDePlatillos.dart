import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

FirebaseFirestore bdPlatillos = FirebaseFirestore.instance;

Future<List> leerPlatillos() async {
  List platillos = [];
  CollectionReference platillosCollection = bdPlatillos.collection('platillos');
  QuerySnapshot platillosObtenidos = await platillosCollection.get();

  platillosObtenidos.docs.forEach((platillo) {
    platillos.add(platillo.data());
  });
  return platillos;
}

void eliminarPlatillo(String nombre) async {
  CollectionReference platillosCollection = bdPlatillos.collection('platillos');
  platillosCollection.where('nombre', isEqualTo: nombre).get().then((snapshot) {
    snapshot.docs.first.reference.delete();
  });
}

void agregarPlatillo(
    String nombre, String precio, String descripcion, String categoria) async {
  CollectionReference platillosCollection = bdPlatillos.collection('platillos');
  platillosCollection.add({
    'nombre': nombre,
    'precio': precio,
    'descripcion': descripcion,
    'categoria': categoria,
    'fecha': DateTime.now(),
    'name': FirebaseAuth.instance.currentUser!.displayName,
    'userId': FirebaseAuth.instance.currentUser!.uid,
  });
}

CollectionReference platillos =
    FirebaseFirestore.instance.collection('platillos');

actualizarPlatillo(nombre, precio, descripcion, categoria) {
  platillos
      .where('nombre', isEqualTo: nombre)
      .get()
      .then((snapshot) {
        snapshot.docs.first.reference.update({
          'nombre': nombre,
          'precio': precio,
          'descripcion': descripcion,
          'categoria': categoria
        });
      })
      .then((value) => print("Platillo actualizado correctamente."))
      .catchError((error) => print("Fallo al actualizar el platillo: $error"));
  ;
}
