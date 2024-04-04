import "package:flutter/material.dart";

import "package:palominos/src/Funciones_BD.dart";
import "Clase_Pedido.dart";

class Ventas extends StatefulWidget {
  const Ventas({super.key});

  @override
  State<Ventas> createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  double total = 0;
  List elemento = elementos();
  List ventas = [];
  TextEditingController buscarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 100,
            actions: [
              Text(
                'Total \$${total.toString()}',
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                  onPressed: () {
                    busquedaEnBD(buscarController.text);
                    buscarController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add_box_rounded,
                    color: Colors.black,
                  ))
            ],
            centerTitle: true,
            title: SizedBox(
                height: 80,
                child: Center(
                  child: TextField(
                    controller: buscarController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 15),
                      hintTextDirection: TextDirection.ltr,
                      hintText: "Buscar",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ))),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Agregar pedido',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          onPressed: () {
            Map<String, dynamic> mapa = {};
            // agregarPedido(ventas, total);
            ventas.asMap().forEach((index, element) {
              mapa[element.nombre] = {
                'nombre': element.nombre,
                'precio': element.precio,
                'cantidad': element.cantidad,
                'descripcion': element.descripcion
              };
            });
            agregarPedido(mapa, total);
            ventas.clear();
            total = 0;
            buscarController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.add_to_photos_rounded, color: Colors.white),
        ),
        body: ListView(
          children: ventas.map((e) {
            TextEditingController descripcionController =
                TextEditingController(text: e.descripcion);

            return Card(
                child: Column(children: [
              ListTile(
                title: Text(e.nombre),
                subtitle: Text(e.precio),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        e.descripcion = descripcionController.text;
                      },
                      icon: const Icon(Icons.check_box)),
                  Expanded(
                    child: TextFormField(
                        controller: descripcionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descripción',
                        )),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          e.cantidad--;
                          total = total - double.parse((e.precio));
                          if (e.cantidad == 0) {
                            ventas.remove(e);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove)),
                  Text(e.cantidad.toString()),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          e.cantidad++;
                          total = total + double.parse(e.precio);
                        });
                      },
                      icon: const Icon(Icons.add)),
                ],
              )
            ]));
          }).toList(),
        ));
  }

  void busquedaEnBD(String plato) {
    for (var i = 0; i < elemento.length; i++) {
      var dato = elemento[i].nombre.toLowerCase();
      if (dato == plato.toLowerCase()) {
        print('Se encontró el elemento dentro de la lista');
        Pedido pedido = Pedido(
          nombre: elemento[i].nombre,
          precio: elemento[i].precio,
          cantidad: 1,
          descripcion: '',
        );
        bool comprobacion = existeEnLista(pedido.nombre);
        if (comprobacion != true) {
          ventas.add(pedido);
          total = total + double.parse(pedido.precio);
        }
        break;
      } else {
        print('No se encontró el elemento dentro de la lista');
      }
    }
  }

  bool existeEnLista(String plato) {
    for (var i = 0; i < ventas.length; i++) {
      if (ventas[i].nombre == plato) {
        print('ya existe en la lista');
        return true;
      }
    }
    return false;
  }
}
