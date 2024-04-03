import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:palominos/Platillos_Funciones/Clase_Platillo.dart";

FirebaseFirestore bdPlatillos = FirebaseFirestore.instance;
CollectionReference platillosCollection = bdPlatillos.collection('platillos');
CollectionReference pedidosCollection = bdPlatillos.collection('pedidos');

void agregarPedido(Map pedido, double total) async {
  pedidosCollection.add({
    'Pedido': pedido,
    'total': total,
    'fecha': DateTime.now(),
    'name': FirebaseAuth.instance.currentUser!.displayName,
    'userId': FirebaseAuth.instance.currentUser!.uid,
  }).then((value) {
    print("Pedido agregado correctamente.");
  }).catchError((e) {
    print("Error al agregar pedido: $e");
  });
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
}

elementos() {
  List lista = [];
  Platilloclass platillo = Platilloclass(
      id: "", nombre: "", precio: "", descripcion: "", categoria: "");
  platillosCollection.get().then((snapshot) {
    snapshot.docs.forEach((element) {
      platillo = Platilloclass(
        id: element.id,
        nombre: element['nombre'],
        precio: element['precio'],
        descripcion: element['descripcion'],
        categoria: element['categoria'],
      );
      lista.add(platillo);
    });
  });
  return lista;
}
