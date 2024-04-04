import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palominos/Pedidos_Funciones/Ventas.dart';
import 'package:palominos/src/Funciones_BD.dart';
import 'package:palominos/src/funcion_red.dart';

import 'Clase_Pedido.dart';

class ScPedidos extends StatefulWidget {
  const ScPedidos({super.key});

  @override
  State<ScPedidos> createState() => _ScPedidosState();
}

final Stream<QuerySnapshot> _pedidosRead = FirebaseFirestore.instance
    .collection('pedidos')
    .orderBy('fecha')
    .snapshots();

class _ScPedidosState extends State<ScPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (conectividad() != 'Sin conexion') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ventas(),
                      )).then((value) => setState(() {}));
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
              Timestamp timestamp = data['fecha'] as Timestamp;
              DateTime dateTime = timestamp.toDate();
              var horaPedido =
                  'Fecha: ${dateTime.day}/${dateTime.month}/${dateTime.year} Hora: ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

              return Card(
                  child: Column(
                children: [
                  ListTile(
                    title: Text(horaPedido +
                        '\n' +
                        pedido.entries
                            .map((e) =>
                                '${e.key}  \ncantidad: ${e.value['cantidad'].toString()}, precio: ${e.value['precio'].toString()}, descripcion: ${e.value['descripcion']} \n')
                            .join('\n')),
                    subtitle: Text('Total: \$${data['total'].toString()}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            document.reference.delete();
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            agregarVenta(data['Pedido'], data['total']);
                            document.reference.delete();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pedido realizado',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.send, color: Colors.white)
                            ],
                          )),
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
