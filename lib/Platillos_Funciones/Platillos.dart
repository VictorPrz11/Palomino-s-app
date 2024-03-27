import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:palominos/Platillos_Funciones/CrudPlatillos.dart";

import "LecturaDePlatillos.dart";

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CrudPlatillos("", "", "", ""),
                    )).then((value) {
                  agregarPlatillo(value['nombre'], value['precio'],
                      value['descripcion'], value['categoria']);
                  setState(() {});
                });
              },
            )
          ],
          title: const Text('Platillos'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _platillosRead,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Algo salió mal');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return SizedBox(
                    height: 150,
                    child: Card(
                        child: Row(
                      children: [
                        Expanded(
                            child: ListTile(
                          title: Text(data["nombre"]),
                          subtitle: Text("\$" + data["precio"]),
                        )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CrudPlatillos(
                                          data["categoria"],
                                          data["descripcion"],
                                          data["precio"],
                                          data["nombre"]))).then((value) {
                                actualizarPlatillo(
                                    value['nombre'],
                                    value['precio'],
                                    value['descripcion'],
                                    value['categoria']);
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                          icon: const Icon(Icons.delete),
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
                        )
                      ],
                    )));
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