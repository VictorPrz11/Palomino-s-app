import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

import "package:palominos/Platillos_Funciones/CrudPlatillos.dart";
import "package:palominos/src/widgets.dart";

import "../src/Funciones_BD.dart";
import "../src/funcion_red.dart";

class Platillos extends StatefulWidget {
  const Platillos({super.key});

  @override
  State<Platillos> createState() => _PlatillosState();
}

final Stream<QuerySnapshot> _platillosRead =
    FirebaseFirestore.instance.collection('platillos').snapshots();

class _PlatillosState extends State<Platillos> {
  @override
  Widget build(BuildContext context) {
    String conexion = '';
    verificarConexion().then((value) => setState(() {
          conexion = value;
        }));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                if (conexion == 'conexion') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CrudPlatillos('', '', '', ''),
                      )).then((value) {
                    agregarPlatillo(value['nombre'], value['precio'],
                        value['descripcion'], value['categoria']);
                    setState(() {});
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No hay conexion a internet'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cerrar'))
                      ],
                    ),
                  );
                }
              },
            )
          ],
          title: const Header('Platillos'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _platillosRead,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Algo salió mal'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(8),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                var id = document.id;
                return Card(
                    child: Column(
                  children: [
                    ListTile(
                        // contentPadding:
                        //     const EdgeInsets.fromLTRB(15, 10, 25, 0),
                        subtitle: Text("\$" + data["precio"]),
                        title: Text(
                          data["nombre"],
                        ),
                        // isThreeLine: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        titleAlignment: ListTileTitleAlignment.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CrudPlatillos(
                                            data["categoria"],
                                            data["descripcion"],
                                            data["precio"],
                                            data["nombre"],
                                          ))).then((value) {
                                actualizarPlatillo(
                                    id,
                                    value['nombre'],
                                    value['precio'],
                                    value['descripcion'],
                                    value['categoria']);
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirmar Eliminación"),
                                    content: const Text(
                                        "¿Estás seguro de que quieres eliminar este platillo?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Cancelar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Eliminar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          eliminarPlatillo(data["nombre"]);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ));
              }).toList(),
            );
          },
        ));
  }
}
// FutureBuilder(
//           future: leerPlatillos(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                         title: Text(snapshot.data![index]["nombre"]),
//                         subtitle: Text("\$" + snapshot.data![index]["precio"]),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Confirmar Eliminación"),
//                                   content: Text(
//                                       "¿Estás seguro de que quieres eliminar este platillo?"),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       child: Text("Cancelar"),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: Text("Eliminar"),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                         eliminarPlatillo(
//                                             snapshot.data![index]["nombre"]);
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ).then((value) {
//                               setState(() {});
//                             });
//                           },
//                         )),
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         )