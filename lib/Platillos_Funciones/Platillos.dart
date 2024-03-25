import "package:flutter/material.dart";
import "package:palominos/Platillos_Funciones/AddPlatillos.dart";
import "package:palominos/Platillos_Funciones/CrudPlatillos.dart";

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
                    ));
              },
            )
          ],
          title: const Text('Platillos'),
        ),
        body: ListView(
          children: [],
        ));
  }
}
