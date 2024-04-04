import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palominos/Ventas.dart';

import 'Clase_Pedido.dart';

class ScPedidos extends StatefulWidget {
  const ScPedidos({super.key});

  @override
  State<ScPedidos> createState() => _ScPedidosState();
}

final Stream<QuerySnapshot> _pedidosRead =
    FirebaseFirestore.instance.collection('pedidos').snapshots();

class _ScPedidosState extends State<ScPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ventas(),
                    )).then((value) => setState(() {}));
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text('Pedidos'),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: _pedidosRead,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo salió mal');
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
              Map<String, dynamic> pedido = data['Pedido'];

              return Card(
                  child: Column(
                children: [
                  ListTile(
                    title: Text(pedido.entries
                        .map((e) =>
                            '${e.key}\ncantidad: ${e.value['cantidad'].toString()}, precio: ${e.value['precio'].toString()}, descripcion: ${e.value['descripcion']} \n')
                        .join('\n')),
                    subtitle: Text('Total: \$${data['total'].toString()}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pedido realizado'),
                            ],
                          )),
                      IconButton(
                          onPressed: () {
                            document.reference.delete();
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  )
                ],
              ));
            }).toList(),
          );
        },
      )),
    );
  }
}
