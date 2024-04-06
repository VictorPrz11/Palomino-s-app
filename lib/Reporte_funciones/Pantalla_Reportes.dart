import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palominos/src/widgets.dart';

class ScReportes extends StatefulWidget {
  const ScReportes({super.key});

  @override
  State<ScReportes> createState() => _ScReportesState();
}

final Stream<QuerySnapshot> _ventasRead = FirebaseFirestore.instance
    .collection('ventas')
    .orderBy('fecha')
    .snapshots();

class _ScReportesState extends State<ScReportes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Header('Reportes'),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: _ventasRead,
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
              Map<String, dynamic> venta = data['Venta'];
              Timestamp timestamp = data['fecha'] as Timestamp;
              DateTime dateTime = timestamp.toDate();

              var horaVenta =
                  'Fecha: ${dateTime.day}/${dateTime.month}/${dateTime.year} Hora: ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
              return Card(
                child: Column(children: [
                  ListTile(
                    title: Text('Vendedor: ${data['name']}'),
                    subtitle: Text(horaVenta),
                  ),
                  ListTile(
                    title: Text('Total: \$${data['total']}'),
                  ),
                  ListTile(
                    title: Text(
                        'Venta:\n${venta.entries.map((e) => '${e.key}, precio \$${e.value['precio'].toString()}, cantidad ${e.value['cantidad'].toString()}').join('\n')}'),
                  ),
                ]),
              );
            }).toList(),
          );
        },
      )),
    );
  }
}
