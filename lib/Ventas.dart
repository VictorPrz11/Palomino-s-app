import "package:flutter/material.dart";

class Ventas extends StatefulWidget {
  const Ventas({super.key});

  @override
  State<Ventas> createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ventas'),
        ),
        body: const Center(
          child: Text('Ventas'),
        ));
  }
}
