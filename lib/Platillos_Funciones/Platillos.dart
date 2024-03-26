import "package:flutter/material.dart";
import "package:palominos/Platillos_Funciones/AddPlatillos.dart";

import "LecturaDePlatillos.dart";

class Platillos extends StatefulWidget {
  const Platillos({super.key});

  @override
  State<Platillos> createState() => _PlatillosState();
}

class _PlatillosState extends State<Platillos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlatillos(),
                    )).then((value) => setState(() {}));
              },
            )
          ],
          title: const Text('Platillos'),
        ),
        body: FutureBuilder(
          future: leerPlatillos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index]['nombre']),
                      subtitle: Text(
                          "\$" + snapshot.data![index]['precio'].toString()),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
