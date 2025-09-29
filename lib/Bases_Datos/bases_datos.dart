import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/global.dart';

class BasesDatos extends StatelessWidget {
  const BasesDatos({super.key});

  @override
  Widget build(BuildContext context) {
    return BasesDato();
  }
}

class BasesDato extends StatefulWidget {
  const BasesDato({super.key});

  @override
  State<BasesDato> createState() => _BasesDatoState();
}

class _BasesDatoState extends State<BasesDato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar2(
        actions: [],
        nombre: '',
        progreso: ProgresoGlobal.progreso,
      ),
      drawer: Menu(currentScreen: 'BaseDeDatos'),
    );
  }
}
