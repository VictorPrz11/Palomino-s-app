import 'package:flutter/material.dart';
import 'package:palominos/Platillos_Funciones/CrudPlatillos.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class AddPlatillos extends StatefulWidget {
  const AddPlatillos({super.key});

  @override
  State<AddPlatillos> createState() => _AddPlatillosState();
}

class _AddPlatillosState extends State<AddPlatillos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Platillos'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Consumer<ApplicationState>(
                builder: (context, appState, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (appState.loggedIn) ...[
                      CrudPlatillos(
                        platillo: (nombre, precio, descripcion, categoria) =>
                            appState.addPlatillo(
                                nombre, precio, descripcion, categoria),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
