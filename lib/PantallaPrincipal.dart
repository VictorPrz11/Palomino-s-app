import "package:flutter/material.dart";
import "package:palominos/Reportes.dart";
import "package:palominos/Ventas.dart";

import "Platillos_Funciones/Platillos.dart";

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.restaurant),
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
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                            title: Column(children: [
                          Image.asset('assets/knife.png'),
                          Text(
                            'Platillos',
                          )
                        ])),
                      ),
                    ))),
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Ventas()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                            title: Column(children: [
                          Image.asset('assets/ventas.png'),
                          Text(
                            'Ventas',
                          )
                        ])),
                      ),
                    ))),
          ])),
          Container(
              child: Row(children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reportes()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                            title: Column(children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Image.asset('assets/report.png'),
                          ),
                          Text(
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
