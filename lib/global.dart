import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProgresoGlobal {
  static final Set<int> subtemasVistos = {};
  static final Set<int> todosLosSubtemasIDs = {
    ...List.generate(5, (i) => i + 1),
    ...List.generate(15, (i) => i + 6),
    ...List.generate(4, (i) => i + 21),
    ...List.generate(7, (i) => i + 25),
    ...List.generate(6, (i) => i + 32),
    ...List.generate(3, (i) => i + 38),
    ...List.generate(3, (i) => i + 41),
    ...List.generate(7, (i) => i + 44),
    ...List.generate(5, (i) => i + 51),
  };

  static double get progreso =>
      subtemasVistos.length / todosLosSubtemasIDs.length;

  static Future<void> cargarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('progreso_visto') ?? [];
    subtemasVistos
      ..clear()
      ..addAll(lista.map((e) => int.tryParse(e)).whereType<int>());
  }

  static Future<void> marcarVisto(int id) async {
    if (todosLosSubtemasIDs.contains(id)) {
      subtemasVistos.add(id);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'progreso_visto',
        subtemasVistos.map((e) => e.toString()).toList(),
      );
    }
  }

  static Future<void> reiniciar() async {
    subtemasVistos.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('progreso_visto');
  }
}
//en esta bariable de progeso se esta mostrando el progreso de cada tema

int progreso = 0;
// lib/global.dart
//library global;

/*String usuarioNombre = "";
String fichaNombre = "";
String fichaNumero = "";*/

String usuarioglobal = ''; // aquí se guardará el nombre del usuario

void setUsuarioGlobal(String nombre) {
  usuarioglobal = nombre;
} //en esta linea de codigo se guarda el nombre del usuario

String getUsuarioGlobal() {
  return usuarioglobal;
}

String fichaglobal =
    ''; //en esta linea de codigo se guarda la informacion de la ficha
// se usó esta variable globar para que que guardara la informacion de el progreso, sin esto no funciona no se envia nada a la base de datos

void setFichaGlobal(String ficha) {
  fichaglobal = ficha;
} //en esta linea de codigo se guarda la informacion de la ficha

String getFichaGlobal() {
  return fichaglobal;
}

String programaglobal = '';

void setprogramaGlobal(String programa) {
  programaglobal = programa;
}

String getprogramaGlobal() {
  return programaglobal;
}
//para que funcione correctamente el guardar progresofinal no se debe borrar el nombre y ficha porque es esencial
/*Future<void> guardarProgresoFinal(String id) async {
  final url = Uri.parse("http://192.168.0.105:5000/guardarProgreso");
  //aqui se debe de cambiar la ip segun la red local
  //final url = Uri.parse("http://192.168.101.19:5000/guardarProgreso");
  //final response =
  await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "nombre": usuarioglobal, //aca se esta aplicando el nombre del usario
      "ficha": fichaglobal, // aca se esta aplicando la ficha del usario
      "progreso": id, // aca se esta aplicando el progreso del usario
    }),
  );
} */ // en este bloque de codigo se obtine el progreso y se guarda en la base de datos

//quitar
Future<void> guardarProgresoFinal(int id) async {
  final url = Uri.parse(
    "https://proyecto-api-1vjo.onrender.com/guardarProgreso",
  );
  // Ojo: cambia la IP según tu red local

  await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "nombre": usuarioglobal, // nombre del usuario
      "ficha": fichaglobal,
      // 👇 Ya no es necesario enviar "progreso"
    }),
  );
}

//quitar
