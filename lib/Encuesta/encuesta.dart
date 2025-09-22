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
  final url = Uri.parse("http://192.168.0.103:5000/guardarTodo");

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
                                      value: 'C Correcto', //correcta
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
                                  value: 'A correcto',
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
                                  value: 'D correcto',
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
                                  value: 'B correcto',
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
                                      value: 'D correcto',
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
                                  value: 'B correcto',
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
                                  groupValue: _justificacionpregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _justificacionpregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Argumentar la problemática y describir la conveniencia.',
                                  value: 'B correcto',
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
                                  value: 'B correcto',
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
                                  value: 'D correcto',
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
                                  value: 'C correcto',
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
                                  value: 'B correcto',
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
                                  value: 'A correcto',
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
                                  value: 'D correcto',
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
                                  value: 'C correcto',
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
                                  value: 'B correcto',
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
                                  value: 'D correcto',
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
                                  value: 'B correcto',
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
                                  value: 'D correcto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _cronogramapregunta3 = val,
                                      ),
                                ),
                              ],
                            ),
                          ),

                          if (_titulopregunta1 != null &&
                              _plnateamientopregunta2 != null &&
                              _objetivospregunta1 != null &&
                              _metodologiapregunta3 != null)
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
        _funcionboton(context);
      },
      child: Text('Finalizar', style: TextStyle(fontSize: tamanotexto(2))),
    );
  }

  void _funcionboton(BuildContext context) async {
    if (_titulopregunta1 == null ||
        _titulopregunta2 == null ||
        _titulopregunta3 == null ||
        _plnateamientopregunta1 == null ||
        _plnateamientopregunta2 == null ||
        _plnateamientopregunta3 == null ||
        _justificacionpregunta1 == null ||
        _justificacionpregunta1 == null ||
        _justificacionpregunta2 == null ||
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
    }

    {
      /*      //qiotar
      await enviarEncuesta(
        bibliografia: _bibliografia!,
        nombre: usuarioglobal,
        ficha: fichaglobal,
      );*/ //quitar

      _mostrarcamposenblanco2(context, 'Muy bien');
    }
  }

  void _mostrarcamposenblanco2(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Resultado'),
            content: Column(
              children: [
                if (_titulopregunta1 == 'C Correcto') Text('ok'),
                if (_titulopregunta2 == 'Totalmente de acuerdo') Text('ok'),
              ],
            ),
            actions: [
              Center(
                child: SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      _eliminarrespuesta(context);
                      Navigator.of(ctx).pop();
                    },
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
}
