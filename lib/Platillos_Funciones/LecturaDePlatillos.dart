import "package:cloud_firestore/cloud_firestore.dart";

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
