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
  TextEditingController _nombre = TextEditingController();
  TextEditingController _precio = TextEditingController();
  TextEditingController _descripcion = TextEditingController();
  TextEditingController _categoria = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    if (_nombre.text.isEmpty ||
                        _precio.text.isEmpty ||
                        _descripcion.text.isEmpty ||
                        _categoria.text.isEmpty) {
                      return;
                    } else {
                      widget.platillo(_nombre.text, _precio.text,
                          _descripcion.text, _categoria.text);
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
