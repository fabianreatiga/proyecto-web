// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// ------------------------------------------------------
/// GESTOR DEL PROGRESO
/// ------------------------------------------------------
class ProgresoGlobal {
  static final Set<int> pestanasVistas = {};

  /// Lista total de IDs válidos
  static final Set<int> todosLosIDs = {
    ...List.generate(5, (i) => i + 1), // Título
    ...List.generate(15, (i) => i + 7), // Planteamiento
    ...List.generate(4, (i) => i + 22), // Justificación
    ...List.generate(7, (i) => i + 26), // Objetivos
    ...List.generate(4, (i) => i + 33), // Antecedentes
    ...List.generate(6, (i) => i + 37), // Metodología
    ...List.generate(3, (i) => i + 43), // Cronograma
    ...List.generate(3, (i) => i + 46), // Actividades
    ...List.generate(7, (i) => i + 49), // Bibliografía
    ...List.generate(5, (i) => i + 56), // Búsqueda
    ...List.generate(3, (i) => i + 61), // Bases de datos
  };

  /// Progreso total entre 0 y 1
  static double get progreso =>
      todosLosIDs.isEmpty ? 0 : pestanasVistas.length / todosLosIDs.length;

  /// Obtener porcentaje exacto del progreso (0 a 100)
  static int get porcentaje => ((progreso * 100).round());

  /// Cargar progreso local
  static Future<void> cargarLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('progreso_visto') ?? [];

    pestanasVistas
      ..clear()
      ..addAll(lista.map(int.parse));
  }

  /// Guardar progreso local
  static Future<void> guardarLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'progreso_visto',
      pestanasVistas.map((e) => e.toString()).toList(),
    );
  }

  /// Marcar una pestaña como vista
  static Future<void> marcarVisto(int id) async {
    if (!todosLosIDs.contains(id)) return;

    pestanasVistas.add(id);
    await guardarLocal();
  }

  /// Reiniciar progreso
  static Future<void> reiniciar() async {
    pestanasVistas.clear();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('progreso_visto');
  }
}

/// ------------------------------------------------------
/// VARIABLES GLOBALES (USUARIO, FICHA, PROGRAMA)
/// ------------------------------------------------------
String usuarioglobal = "";
String fichaglobal = "";
String programaglobal = "";

void setUsuarioGlobal(String nombre) => usuarioglobal = nombre;
void setFichaGlobal(String ficha) => fichaglobal = ficha;
void setprogramaGlobal(String programa) => programaglobal = programa;

String getUsuarioGlobal() => usuarioglobal;
String getFichaGlobal() => fichaglobal;
String getprogramaGlobal() => programaglobal;

/// ------------------------------------------------------
/// 🔄 SINCRONIZAR PROGRESO DESPUÉS DEL LOGIN (OPCIÓN A)
/// ------------------------------------------------------
/// Se ejecuta DESPUÉS del login
///
/// 1. Carga progreso guardado en MongoDB
/// 2. Actualiza SharedPreferences
/// 3. No reinicia progreso
/// ------------------------------------------------------
/*Future<void> sincronizarProgresoConAPI() async {
  if (usuarioglobal.isEmpty || fichaglobal.isEmpty) return;

  final url = Uri.parse(
    "https://proyecto-api-1vjo.onrender.com/obtenerProgreso",
  );

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"nombre": usuarioglobal, "ficha": fichaglobal}),
  );

  if (response.statusCode != 200) return;

  final data = jsonDecode(response.body);

  if (data["progreso"] == null) return;

  final int progresoGuardado = data["progreso"];

  // Convertir porcentaje a cantidad de IDs vistos
  final int cantidadVistas =
      ((progresoGuardado / 100) * ProgresoGlobal.todosLosIDs.length).round();

  // Limpiar y cargar esos IDs
  ProgresoGlobal.pestanasVistas.clear();
  ProgresoGlobal.pestanasVistas.addAll(
    ProgresoGlobal.todosLosIDs.take(cantidadVistas),
  );

  await ProgresoGlobal.guardarLocal();

}*/

/// ------------------------------------------------------
/// GUARDAR PROGRESO FINAL EN LA API
/// ------------------------------------------------------
Future<void> sincronizarProgresoConAPI() async {
  try {
    final url = Uri.parse(
      "https://proyecto-api-1vjo.onrender.com/progreso"
      "?nombre=$usuarioglobal&ficha=$fichaglobal",
    );

    final response = await http.get(url);

    //print("🔍 STATUS CODE: ${response.statusCode}");
    // print("🔍 RESPUESTA API: ${response.body}");

    if (response.statusCode == 404) {
      //  print("⚠️ No se encontró progreso, iniciando desde 0.");
      ProgresoGlobal.pestanasVistas.clear();
      await ProgresoGlobal.guardarLocal();
      return;
    }

    if (response.statusCode != 200) {
      // print("⚠️ Error al consultar progreso.");
      return;
    }

    final data = jsonDecode(response.body);

    int progresoAPI = data["progreso"] ?? 0;

    //print("🔵 Progreso recibido desde API: $progresoAPI %");

    int total = ProgresoGlobal.todosLosIDs.length;
    int cantidadVistas = ((progresoAPI / 100) * total).round();

    //print("🔵 Pestañas a marcar como vistas: $cantidadVistas de $total");

    ProgresoGlobal.pestanasVistas.clear();
    ProgresoGlobal.pestanasVistas.addAll(
      ProgresoGlobal.todosLosIDs.take(cantidadVistas),
    );

    //print("🔵 IDs cargados: ${ProgresoGlobal.pestanasVistas}");

    await ProgresoGlobal.guardarLocal();
  } catch (e) {
    //print("❌ Error al sincronizar progreso: $e");
  }
}

/// ------------------------------------------------------
/// GUARDAR PROGRESO EN LA API (SUMA +2 HASTA 100)
/// ------------------------------------------------------
Future<void> guardarProgresoEnAPI() async {
  if (usuarioglobal.isEmpty || fichaglobal.isEmpty) return;

  // 🔥 1. Obtener el progreso actual en porcentaje
  final int porcentaje = ProgresoGlobal.porcentaje;

  final url = Uri.parse(
    "https://proyecto-api-1vjo.onrender.com/guardarProgreso",
  );

  // 🔥 2. Enviar progreso, nombre y ficha
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "nombre": usuarioglobal,
      "ficha": fichaglobal,
      "progreso": porcentaje, // <<--- AQUÍ ESTABA EL ERROR
    }),
  );

  print("📡 Enviando PROGRESO: $porcentaje%");
  print("📩 Respuesta API: ${response.body}");
}
