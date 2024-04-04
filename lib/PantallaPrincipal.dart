import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:image_picker/image_picker.dart";
import "package:palominos/Pedidos_Funciones/Pantalla_pedidos.dart";
import "package:palominos/Reporte_funciones/Pantalla_Reportes.dart";

import "package:palominos/Pedidos_Funciones/Ventas.dart";
import "package:palominos/seleccionDdeimagenes.dart";
import "Platillos_Funciones/Pantalla_Platillos.dart";

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.restaurant_menu),
        leadingWidth: 100,
        backgroundColor: Colors.blue[200],
        title: const Text('Palomino´s'),
      ),
      body: Column(
        children: [
          Container(
              child: Row(children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Platillos()));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Image.asset('assets/knife.png'),
                              const Text(
                                'Platillos',
                              )
                            ])),
                      ),
                    ))),
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScPedidos()));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Image.asset('assets/ventas.png'),
                              const Text(
                                'Ventas',
                              )
                            ])),
                      ),
                    ))),
          ])),
          SizedBox(
              child: Row(children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScReportes()));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Image.asset('assets/report.png'),
                              ),
                              const Text(
                                'Reportes',
                              )
                            ])),
                      ),
                    ))),
          ]))
        ],
      ),
    );
  }
}
