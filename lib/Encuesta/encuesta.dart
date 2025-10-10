// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Menus/menus.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuevomockups/global.dart';

// Ahora enviamos nombre y ficha también

//quitar
Future<void> enviarEncuesta({
  required String observacion,
  required String nombre,
  required String ficha,
}) async {
  final url = Uri.parse("https://proyecto-api-1vjo.onrender.com/guardarTodo");

  final respuesta = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "observacion": observacion,
      "nombre": nombre,
      "ficha": ficha,
      //"fecha": DateTime.now().toIso8601String(),
    }),
  );

  if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
    throw Exception("Error al enviar encuesta: ${respuesta.body}");
  }
  debugPrint(
    "📤 Enviando: ${jsonEncode({"observacion": observacion, "nombre": nombre, "ficha": ficha})}",
  );
}

Future<void> enviarintentos({
  required String nombre,
  required String ficha,
  required int intentos,
}) async {
  final url = Uri.parse("https://proyecto-api-1vjo.onrender.com/guardarTodo");

  final respuesta = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "intentos": intentos,
      "nombre": nombre,
      "ficha": ficha,
      //"fecha": DateTime.now().toIso8601String(),
    }),
  );

  if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
    throw Exception("Error al enviar encuesta: ${respuesta.body}");
  }
  debugPrint("📤 Enviando: ${jsonEncode({"nombre": nombre, "ficha": ficha})}");
}
//Quitar

class Encuesta extends StatelessWidget {
  const Encuesta({super.key});

  @override
  Widget build(BuildContext context) {
    return const Encuestas();
  }
}

class Encuestas extends StatefulWidget {
  const Encuestas({super.key});

  @override
  State<Encuestas> createState() => _EncuestasState();
}

void _mostrarcamposenblanco(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text(mensaje),
          actions: [
            Center(
              child: SizedBox(
                width: 100,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: obtenercolor('Color_Principal'),
                    foregroundColor: obtenercolor('Color_Texto_Principal'),
                  ),
                  child: const Text('Aceptar'),
                ),
              ),
            ),
          ],
        ),
  );
}

class _EncuestasState extends State<Encuestas> {
  String? _titulopregunta1; // en esta variable se guarda el titulo
  String? _titulopregunta2;
  String? _titulopregunta3;
  String? _plnateamientopregunta1;
  String? _plnateamientopregunta2;
  String? _plnateamientopregunta3;
  String? _justificacionpregunta1;
  String? _justificacionpregunta2;
  String? _justificacionpregunta3;
  String? _objetivospregunta1;
  String? _objetivospregunta2;
  String? _objetivospregunta3;
  String? _metodologiapregunta1;
  String? _metodologiapregunta2;
  String? _metodologiapregunta3;
  String? _cronogramapregunta1;
  String? _cronogramapregunta2;
  String? _cronogramapregunta3;
  String? _actiivadadespregunta1;
  String? _actiivadadespregunta2;
  String? _actiivadadespregunta3;
  String? _bibliografiapregunta1;
  String? _bibliografiapregunta2;
  String? _bibliografiapregunta3;

  final TextEditingController _observaciontext = TextEditingController();

  Widget _buildOpcion({
    required String texto,
    required String value,
    required String? groupValue,
    required Function(String?) onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Expanded(child: Text(texto, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbar2(nombre: '', progreso: 100, actions: []),
      drawer: Menu(currentScreen: 'Encuesta'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Card(
                  color: obtenercolor('Color_Fondo'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(30),

                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Preguntas (1 a 4) siguen igual
                          Text(
                            '1. ¿Porque el título de un proyecto es importante?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildOpcion(
                                      texto:
                                          'A) El título es importante porque contiene todos los objetivos específicos del proyecto.',
                                      value: 'A incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'B) El título es importante porque es lo primero que se escribe.',
                                      value: 'B incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'C) El título es importante porque identifica el proyecto.',
                                      value: 'correcto', //correcta
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'D) Porque todos los proyectos deben tener un título.',
                                      value: 'D incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '2. ¿En promedio, cuántas palabras debe contener el título de un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) En promedio de 12 a 20 palabras.',
                                  value: 'correcto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) En promedio de 10 a 15 palabras.',
                                  value: 'B incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) En promedio de 20 a 30 palabras.',
                                  value: 'C incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) En promedio de 15 a 20 palabras.',
                                  value: 'D incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '3. ¿Cuántas partes tiene el título de un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) 7.',
                                  value: 'A incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 5.',
                                  value: 'B incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 6.',
                                  value: 'C incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 3.',
                                  value: 'correcto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '4. ¿Cuáles son las 4 metodologías que se hablan en el planteamiento del problema?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) Clear, Smart, Pure, Grow.',
                                  value: 'A incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) 5WIH, Espina de pesacado, Árbol de problemas, Esquema de redacción.',
                                  value: 'correcto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C)What, When, Where, How.',
                                  value: 'C incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Hipótesis,Cronograma, Objetivos, Conclusiones.',
                                  value: 'D incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '5. ¿Cuántas preguntas incluye la metodología 5W1H?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          Center(
                            child: SizedBox(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildOpcion(
                                      texto: 'A) 3.',
                                      value: 'A incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto: 'B) 4.',
                                      value: 'B incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto: 'C) 5.',
                                      value: 'C incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto: 'D) 6.',
                                      value: 'correcto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '6. ¿Qué representan las 6M en la espina de pesacado?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Metodología, manual, muestra, monitoreo, movimiento y marco.',
                                  value: 'A incorrecto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Máquinaria, mano de obra, materiales, métodos, medio ambiente y medición.',
                                  value: 'correcto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Manejo, mensualidad, memoria, modelo, mercado y módulo.',
                                  value: 'C incorrecto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Meta, marco teórico, motivación, medios, misión y modelo.',
                                  value: 'D incorrecto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '7. ¿Cuál es el propósito principal de la justificación de un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Presentar solo los resultados finales.',
                                  value: 'A incorrecto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Argumentar la problemática y describir la conveniencia.',
                                  value: 'correcto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Explicar únicamente los costos económicos.',
                                  value: 'C incorrecto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Hacer un resumen corto del proyecto.',
                                  value: 'D incorrecto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          Text(
                            '8. ¿Cuántas preguntas tiene el paso a paso de la imagen de justificación?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) 4',
                                  value: 'A incorrecto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 5',
                                  value: 'correcto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 6',
                                  value: 'C incorrecto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 7',
                                  value: 'D incorrecto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '9. ¿Cuál es el lenguaje más indicado para redactar la justificación de un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) En primera persona, para que se note más personal.',
                                  value: 'A incorrecto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) En segunda persona, para dirigirse al lector directamente.',
                                  value: 'B incorrecto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) En un lenguaje coloquial, para que sea más cercano.',
                                  value: 'C incorrecto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) En tercera persona, para dar mayor seriedad e imparcialidad.',
                                  value: 'correcto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '10. ¿Cuál es la metodología más utilizada para establecer un objetivo?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) DUMB.',
                                  value: 'A incorrecto',
                                  groupValue: _objetivospregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) PURE.',
                                  value: 'B incorrecto',
                                  groupValue: _objetivospregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) SMART.',
                                  value: 'correcto',
                                  groupValue: _objetivospregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) CLEAR.',
                                  value: 'D incorrecto',
                                  groupValue: _objetivospregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '11. ¿Cuál de las siguientes opciones corresponde a las características de un objetivo SMART?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Seguro, Moderno, Adaptable, Rápido y Temporal.',
                                  value: 'A incorrecto',
                                  groupValue: _objetivospregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Específico, Medible, Alcanzable, Relevante y en Tiempo.',
                                  value: 'correcto',
                                  groupValue: _objetivospregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Sencillo, Motivador, Actual, Realista y Técnico.',
                                  value: 'C incorrecto',
                                  groupValue: _objetivospregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Estratégico, Mínimo, Apropiado, Reducido y Tolerante.',
                                  value: 'D incorrecto',
                                  groupValue: _objetivospregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '12. ¿Cuál es la finalidad principal del árbol de objetivos?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Reunir medios y alternativas para solucionar el problema principal, logrando una visión positiva.',
                                  value: 'correcto',
                                  groupValue: _objetivospregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Evitar la búsqueda de soluciones paso a paso.',
                                  value: 'B incorrecto',
                                  groupValue: _objetivospregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Plantear los pasos negativos del proyecto.',
                                  value: 'C incorrecto',
                                  groupValue: _objetivospregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Reunir información sin relación con el problema.',
                                  value: 'D incorrecto',
                                  groupValue: _objetivospregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _objetivospregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '13. ¿Por qué es importante la elección de la metodología de investigación en un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Porque determina el resultado de la investigación.',
                                  value: 'A incorrecto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Porque es un requisito sin relevancia.',
                                  value: 'B incorrecto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Porque solo sirve para justificar los resultados.',
                                  value: 'C incorrecto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Porque determina todo el rumbo de la investigación.',
                                  value: 'correcto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '14. ¿Cuántos tipos principales de metodologías de investigación existen?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) 1.',
                                  value: 'A incorrecto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 2.',
                                  value: 'B incorrecto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 3.',
                                  value: 'correcto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 4.',
                                  value: 'D incorrecto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '15. ¿Qué se debe conocer para poder seleccionar la mejor metodología de investigación?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Solo la experiencia de otros investigadores.',
                                  value: 'A incorrecto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Los factores que influyen en la decisión, las metodologías que existen y los pasos para elegir la adecuada.',
                                  value: 'correcto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) El tiempo disponible para la investigación.',
                                  value: 'C incorrecto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Únicamente los resultados esperados.',
                                  value: 'D incorrecto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _metodologiapregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '16. ¿Cuál es una de las ventajas de la gestión de proyectos respecto al cronograma?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Que evita la planificación del trabajo.',
                                  value: 'A incorrecto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Que elimina la necesidad de usar tecnología.',
                                  value: 'B incorrecto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Que hace innecesaria la organización del equipo.',
                                  value: 'C incorrecto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Que permite visualizar el trabajo en un cronograma de actividades en lugar de una lista desorganizada.',
                                  value: 'correcto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '17. ¿Qué ofrece un cronograma de actividades en la gestión de proyectos?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Una lista de pendientes sin orden.',
                                  value: 'A incorrecto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Una idea clara de cómo encajan todas las piezas del plan.',
                                  value: 'correcto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) La posibilidad de trabajar sin estructura.',
                                  value: 'C incorrecto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Una reducción del tiempo de ejecución sin planificación.',
                                  value: 'D incorrecto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '18. ¿Por qué puede resultar complicado crear un cronograma de actividades?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Porque los proyectos no necesitan organización.',
                                  value: 'A incorrecto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Porque siempre depende del jefe del proyecto.',
                                  value: 'B incorrecto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Porque requiere demasiado presupuesto.',
                                  value: 'C incorrecto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Porque se necesita la tecnología adecuada.',
                                  value: 'correcto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '19 ¿Con qué fin se crean las actividades del proyecto en cada una de las fases?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto:
                                      'A) Con el fin de alcanzar los objetivos propuestos.',
                                  value: 'correcto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Con el fin de registrar únicamente los costos.',
                                  value: 'B incorrecto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Con el fin de reemplazar el cronograma.',
                                  value: 'C incorrecto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Con el fin de eliminar los roles de ejecución.',
                                  value: 'D incorrecto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '20. ¿Cuántos resultados esperados debe tener como mínimo cada objetivo de un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) Ninguno.',
                                  value: 'A incorrecto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Uno.',
                                  value: 'correcto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) Dos.',
                                  value: 'C incorrecto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) Varios sin limites.',
                                  value: 'D incorrecto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '21.¿Cómo deben especificarse los resultados esperados en un proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) Según lo decida el patrocinador.',
                                  value: 'A incorrecto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Únicamente al final del proyecto.',
                                  value: 'B incorrecto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) En cualquier orden y sin límite de tiempo.',
                                  value: 'C incorrecto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) En el orden y período de tiempo en el cual se pretenden alcanzar.',
                                  value: 'correcto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _actiivadadespregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '22. ¿Para qué sirve la citación de un autor en un trabajo de investigación?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) Para evitar el plagio',
                                  value: 'correcto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Para llenar espacio.',
                                  value: 'B incorrecto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) Para confundir al lector.',
                                  value: 'C incorrecto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) Para cambiar la información.',
                                  value: 'D incorrecto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta1 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '23. ¿Cuáles son las dos normas de citación que se mencionan en bibliografía?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) Normas ICONTEC y Normas ISO 9001.',
                                  value: 'A incorrecto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Normas Vancouver y Normas MLA.',
                                  value: 'B incorrecto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) Normas APA y Normas IEEE.',
                                  value: 'correcto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Normas ISO 14000 y Normas ICONTEC.',
                                  value: 'D incorrecto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta2 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '24. ¿qué elementos deben incluirse al citar un autor en el cuerpo del texto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'A) El número de página y el editor.',
                                  value: 'A incorrecto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Únicamente el año de publicación.',
                                  value: 'B incorrecto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Su nombre y el año de publicación.',
                                  value: 'correcto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) Solo el título de la obra.',
                                  value: 'D incorrecto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _bibliografiapregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),

                          if (_titulopregunta1 != null &&
                              _plnateamientopregunta2 != null &&
                              _objetivospregunta1 != null &&
                              _metodologiapregunta3 != null &&
                              _actiivadadespregunta2 != null &&
                              _bibliografiapregunta3 != null)
                            Center(
                              child: SizedBox(
                                height: 45,
                                width: 150,
                                child: _bonton(context),
                              ),
                            ),

                          const SizedBox(height: 30),

                          // Botón Enviar
                        ],
                      ),
                    ),
                  ),
                ),

                _card(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return Card(
      color: obtenercolor('Color_Fondo'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            TextField(
              controller: _observaciontext,
              decoration: InputDecoration(
                labelText:
                    '¿Cómo fue su experiencia al usar el aplicativo y por qué?',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: obtenercolor('Color_Principal'),
                  foregroundColor: obtenercolor('Color_Texto_Principal'),
                ),
                onPressed: () {
                  _respuesta(context);
                },
                child: Text(
                  'Enviar Respuesta',
                  style: TextStyle(fontSize: tamanotexto(2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _respuesta(BuildContext context) async {
    final respuesta = _observaciontext.text.trim();

    await enviarEncuesta(
      observacion: respuesta,
      nombre: usuarioglobal,
      ficha: fichaglobal,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text("Muchas por su opinión 😊")),
        backgroundColor: obtenercolor('Color_Principal'),
      ),
    );

    _observaciontext.clear();
  }

  Widget _bonton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: obtenercolor('Color_Principal'),
        foregroundColor: obtenercolor('Color_Texto_Principal'),
      ),
      onPressed: () {
        if (_titulopregunta1 == null ||
            _titulopregunta2 == null ||
            _titulopregunta3 == null ||
            _plnateamientopregunta1 == null ||
            _plnateamientopregunta2 == null ||
            _plnateamientopregunta3 == null ||
            _justificacionpregunta1 == null ||
            _justificacionpregunta2 == null ||
            _justificacionpregunta3 == null ||
            _objetivospregunta1 == null ||
            _objetivospregunta2 == null ||
            _objetivospregunta3 == null ||
            _metodologiapregunta1 == null ||
            _metodologiapregunta2 == null ||
            _metodologiapregunta3 == null ||
            _cronogramapregunta1 == null ||
            _cronogramapregunta2 == null ||
            _cronogramapregunta3 == null ||
            _actiivadadespregunta1 == null ||
            _actiivadadespregunta2 == null ||
            _actiivadadespregunta3 == null ||
            _bibliografiapregunta1 == null ||
            _bibliografiapregunta2 == null ||
            _bibliografiapregunta3 == null) {
          _mostrarcamposenblanco(context, 'No puede haber campos en blanco');
          return;
        } else {
          _funcionboton(context);
        }
      },
      child: Text('Finalizar', style: TextStyle(fontSize: tamanotexto(2))),
    );
  }

  void _eliminarrespuesta(BuildContext context) {
    setState(() {
      _titulopregunta1 = null;
      _titulopregunta2 = null;
      _titulopregunta3 = null;
      _plnateamientopregunta1 = null;
      _plnateamientopregunta2 = null;
      _plnateamientopregunta3 = null;
      _justificacionpregunta1 = null;
      _justificacionpregunta2 = null;
      _justificacionpregunta3 = null;
      _objetivospregunta1 = null;
      _objetivospregunta2 = null;
      _objetivospregunta3 = null;
      _metodologiapregunta1 = null;
      _metodologiapregunta2 = null;
      _metodologiapregunta3 = null;
      _cronogramapregunta1 = null;
      _cronogramapregunta2 = null;
      _cronogramapregunta3 = null;
      _actiivadadespregunta1 = null;
      _actiivadadespregunta2 = null;
      _actiivadadespregunta3 = null;
      _bibliografiapregunta1 = null;
      _bibliografiapregunta2 = null;
      _bibliografiapregunta3 = null;
    });
  }

  void _funcionboton(BuildContext context) {
    int totalCorrectas = 0;
    List<String> resultados = [];

    // --- Título ---
    if (_titulopregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 1 (Título): ✅ Correcta");
    } else {
      resultados.add("Pregunta 1 (Título): ❌ Incorrecta");
    }

    if (_titulopregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 2 (Título): ✅ Correcta");
    } else {
      resultados.add("Pregunta 2 (Título): ❌ Incorrecta");
    }

    if (_titulopregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 3 (Título): ✅ Correcta");
    } else {
      resultados.add("Pregunta 3 (Título): ❌ Incorrecta");
    }

    // --- Planteamiento ---
    if (_plnateamientopregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 4 (Planteamiento): ✅ Correcta");
    } else {
      resultados.add("Pregunta 4 (Planteamiento): ❌ Incorrecta");
    }

    if (_plnateamientopregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 5 (Planteamiento): ✅ Correcta");
    } else {
      resultados.add("Pregunta 5 (Planteamiento): ❌ Incorrecta");
    }

    if (_plnateamientopregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 6 (Planteamiento): ✅ Correcta");
    } else {
      resultados.add("Pregunta 6 (Planteamiento): ❌ Incorrecta");
    }

    // --- Justificación ---
    if (_justificacionpregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 7 (Justificación): ✅ Correcta");
    } else {
      resultados.add("Pregunta 7 (Justificación): ❌ Incorrecta");
    }

    if (_justificacionpregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 8 (Justificación): ✅ Correcta");
    } else {
      resultados.add("Pregunta 8 (Justificación): ❌ Incorrecta");
    }

    if (_justificacionpregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 9 (Justificación): ✅ Correcta");
    } else {
      resultados.add("Pregunta 9 (Justificación): ❌ Incorrecta");
    }

    // --- Objetivos ---
    if (_objetivospregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 10 (Objetivos): ✅ Correcta");
    } else {
      resultados.add("Pregunta 10 (Objetivos): ❌ Incorrecta");
    }

    if (_objetivospregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 11 (Objetivos): ✅ Correcta");
    } else {
      resultados.add("Pregunta 11 (Objetivos): ❌ Incorrecta");
    }

    if (_objetivospregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 12 (Objetivos): ✅ Correcta");
    } else {
      resultados.add("Pregunta 12 (Objetivos): ❌ Incorrecta");
    }

    // --- Metodología ---
    if (_metodologiapregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 13 (Metodología): ✅ Correcta");
    } else {
      resultados.add("Pregunta 13 (Metodología): ❌ Incorrecta");
    }

    if (_metodologiapregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 14 (Metodología): ✅ Correcta");
    } else {
      resultados.add("Pregunta 14 (Metodología): ❌ Incorrecta");
    }

    if (_metodologiapregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 15 (Metodología): ✅ Correcta");
    } else {
      resultados.add("Pregunta 15 (Metodología): ❌ Incorrecta");
    }

    // --- Cronograma ---
    if (_cronogramapregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 16 (Cronograma): ✅ Correcta");
    } else {
      resultados.add("Pregunta 16 (Cronograma): ❌ Incorrecta");
    }

    if (_cronogramapregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 17 (Cronograma): ✅ Correcta");
    } else {
      resultados.add("Pregunta 17 (Cronograma): ❌ Incorrecta");
    }

    if (_cronogramapregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 18 (Cronograma): ✅ Correcta");
    } else {
      resultados.add("Pregunta 18 (Cronograma): ❌ Incorrecta");
    }

    // --- Actividades ---
    if (_actiivadadespregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 19 (Actividades): ✅ Correcta");
    } else {
      resultados.add("Pregunta 19 (Actividades): ❌ Incorrecta");
    }

    if (_actiivadadespregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 20 (Actividades): ✅ Correcta");
    } else {
      resultados.add("Pregunta 20 (Actividades): ❌ Incorrecta");
    }

    if (_actiivadadespregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 21 (Actividades): ✅ Correcta");
    } else {
      resultados.add("Pregunta 21 (Actividades): ❌ Incorrecta");
    }

    // --- Bibliografía ---
    if (_bibliografiapregunta1 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 22 (Bibliografía): ✅ Correcta");
    } else {
      resultados.add("Pregunta 22 (Bibliografía): ❌ Incorrecta");
    }

    if (_bibliografiapregunta2 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 23 (Bibliografía): ✅ Correcta");
    } else {
      resultados.add("Pregunta 23 (Bibliografía): ❌ Incorrecta");
    }

    if (_bibliografiapregunta3 == "correcto") {
      totalCorrectas++;
      resultados.add("Pregunta 24 (Bibliografía): ✅ Correcta");
    } else {
      resultados.add("Pregunta 24 (Bibliografía): ❌ Incorrecta");
    }

    // --- Calcular nota sobre 100 ---
    double nota = (totalCorrectas / 24) * 100;

    // --- Mostrar resultados ---
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Resultados del Cuestionario"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Puntaje final: ${nota.toStringAsFixed(1)} / 100",
                    style: TextStyle(fontSize: tamanotexto(3)),
                  ),
                  if (nota == 100.0)
                    Text(
                      "Respuestas correctas: $totalCorrectas de 24",
                      style: TextStyle(
                        fontSize: tamanotexto(3) - 6,
                        color: obtenercolor('Color_Principal'),
                      ),
                    ),
                  if (nota != 100.0)
                    Text(
                      "Respuestas correctas: $totalCorrectas de 24",
                      style: TextStyle(
                        fontSize: tamanotexto(3) - 6,
                        color: Colors.red,
                      ),
                    ),
                  const SizedBox(height: 10),
                  Text("Detalle de preguntas:"),
                  const SizedBox(height: 10),
                  ...resultados
                      .map(
                        (r) => Text(
                          r,
                          style: TextStyle(fontSize: tamanotexto(2) - 3),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // uno izq, otro der
                  children: [
                    if (nota == 100)
                      TextButton(
                        onPressed: () {
                          _eliminarrespuesta(context);
                          Navigator.of(ctx).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: obtenercolor('Color_Principal'),
                          foregroundColor: obtenercolor(
                            'Color_Texto_Principal',
                          ),
                        ),
                        child: const Text("Aceptar"),
                      ),
                    if (nota <= 99.9)
                      TextButton(
                        onPressed: () async {
                          await enviarintentos(
                            nombre: usuarioglobal,
                            ficha: fichaglobal,
                            intentos: 1,
                          );
                          _eliminarrespuesta(context);
                          Navigator.of(ctx).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: obtenercolor('Color_Principal'),
                          foregroundColor: obtenercolor(
                            'Color_Texto_Principal',
                          ),
                        ),
                        child: const Text('Intentar Nuevamente'),
                      ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
