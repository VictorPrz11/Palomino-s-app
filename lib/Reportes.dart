import "package:flutter/material.dart";

class Reportes extends StatefulWidget {
  const Reportes({super.key});

  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reportes'),
        ),
        body: const Center(
          child: Text('Reportes'),
        ));
  }
}
