import "dart:async";

import "package:flutter/material.dart";
import "package:palominos/src/widgets.dart";

class CrudPlatillos extends StatefulWidget {
  const CrudPlatillos({super.key, required this.platillo});

  final FutureOr<void> Function(
          String nombre, String precio, String descripcion, String categoria)
      platillo;

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
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          CamposdeTexto(
            "Nombre",
            _nombre,
          ),
          CamposdeTexto(
            "Precio",
            _precio,
          ),
          CamposdeTexto(
            "Descripcion",
            _descripcion,
          ),
          CamposdeTexto(
            "Categoria",
            _categoria,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      widget.platillo(_nombre.text, _precio.text,
                          _descripcion.text, _categoria.text);
                      _categoria.clear();
                      _descripcion.clear();
                      _nombre.clear();
                      _precio.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
