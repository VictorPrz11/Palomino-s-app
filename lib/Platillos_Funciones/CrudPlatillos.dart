import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:palominos/Platillos_Funciones/LecturaDePlatillos.dart";
import "package:palominos/src/widgets.dart";
import '../app_state.dart';

class CrudPlatillos extends StatefulWidget {
  CrudPlatillos(this.categoria, this.descripcion, this.precio, this.nombre,
      {super.key});
  String categoria;
  String descripcion;
  String precio;
  String nombre;
  @override
  State<CrudPlatillos> createState() => _CrudPlatillosState();
}

class _CrudPlatillosState extends State<CrudPlatillos> {
  final _formkey = GlobalKey<FormState>(debugLabel: "_CrudPlatillosState");
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _precio = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _categoria = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nombre.text = widget.nombre;
    _precio.text = widget.precio;
    _descripcion.text = widget.descripcion;
    _categoria.text = widget.categoria;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Platillo'),
      ),
      body: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CamposdeTexto("Nombre", _nombre, "Nombre"),
              CamposdeTexto("Precio", _precio, "Precio"),
              CamposdeTexto("Descripcion", _descripcion, "Descripcion"),
              CamposdeTexto("Categoria", _categoria, "Categoria"),
              SizedBox(
                // margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.9,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'nombre': _nombre.text,
                        'precio': _precio.text,
                        'descripcion': _descripcion.text,
                        'categoria': _categoria.text
                      });
                    }
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
