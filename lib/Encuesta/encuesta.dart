// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
//import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Menus/menus.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuevomockups/Videos/videos.dart';
import 'package:nuevomockups/global.dart';

// Ahora enviamos nombre y ficha también

// Función asíncrona encargada de enviar los datos de la encuesta al servidor
Future<void> enviarEncuesta({
  required String observacion, // Observación final ingresada por el usuario
  required String nombre, // Nombre del usuario que responde la encuesta
  required String ficha, // Ficha asociada al usuario
}) async {
  // URL del endpoint donde se almacenan los datos de la encuesta
  final url = Uri.parse("https://proyecto-web-4xe1.onrender.com/guardarTodo");

  // Petición HTTP POST al backend enviando los datos en formato JSON
  final respuesta = await http.post(
    url,
    headers: {
      "Content-Type":
          "application/json", // Indica que se envía información en JSON
    },
    body: jsonEncode({
      "observacion": observacion, // Observación escrita por el usuario
      "nombre": nombre, // Nombre del usuario
      "ficha": ficha, // Ficha del usuario
    }),
  );

  // Verifica si la respuesta del servidor NO fue exitosa
  // Se aceptan únicamente los códigos 200 (OK) y 201 (CREADO)
  if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
    // Lanza una excepción con el mensaje devuelto por el backend
    throw Exception("Error al enviar encuesta: ${respuesta.body}");
  }

  // Mensaje de depuración para confirmar que los datos fueron enviados correctamente
  debugPrint(
    "📤 Enviando: ${jsonEncode({
          "observacion": observacion,
          "nombre": nombre,
          "ficha": ficha
        })}",
  );
}

// Función asíncrona que envía al servidor la cantidad de intentos realizados por el usuario en el cuestionario
Future<void> enviarintentos({
  required String nombre, // Nombre del usuario
  required String ficha, // Ficha del usuario
  required int intentos, // Número de intentos realizados
}) async {
  // URL del endpoint encargado de guardar los intentos
  final url = Uri.parse(
    "https://proyecto-web-4xe1.onrender.com/guardarintentos",
  );

  // Petición HTTP POST enviando los datos en formato JSON
  final respuesta = await http.post(
    url,
    headers: {
      "Content-Type": "application/json", // Se especifica el tipo de contenido
    },
    body: jsonEncode({
      "intentos": intentos, // Cantidad de intentos
      "nombre": nombre, // Nombre del usuario
      "ficha": ficha, // Ficha asociada
      //"fecha": DateTime.now().toIso8601String(), // Fecha opcional
    }),
  );

  // Verifica que la respuesta del servidor sea correcta
  if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
    // Lanza una excepción si ocurre un error en el envío
    throw Exception("Error al enviar encuesta: ${respuesta.body}");
  }

  // Mensaje de depuración para confirmar los datos enviados
  debugPrint(
    "📤 Enviando: ${jsonEncode({
          "intentos": intentos,
          "nombre": nombre,
          "ficha": ficha
        })}",
  );
}

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

// Función que muestra un cuadro de diálogo cuando existen campos sin completar
void _mostrarcamposenblanco(BuildContext context, String mensaje) {
  // Muestra un diálogo emergente en la pantalla actual
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      // Título del cuadro de diálogo
      title: const Text('Error'),

      // Mensaje dinámico que describe el error ocurrido
      content: Text(mensaje),

      // Acciones disponibles en el diálogo
      actions: [
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              // Cierra el cuadro de diálogo al presionar el botón
              onPressed: () => Navigator.of(ctx).pop(),

              // Estilos personalizados del botón
              style: TextButton.styleFrom(
                backgroundColor: obtenercolor('Color_Principal'),
                foregroundColor: obtenercolor('Color_Texto_Principal'),
              ),

              // Texto del botón
              child: const Text('Aceptar'),
            ),
          ),
        ),
      ],
    ),
  );
}

class _EncuestasState extends State<Encuestas> {
  // Contador que registra el número de intentos realizados en la encuesta
  int _intentos = 1;

  String?
      _titulopregunta1; // Almacena la respuesta de la primera pregunta del título
  String?
      _titulopregunta2; // Almacena la respuesta de la segunda pregunta del título
  String?
      _titulopregunta3; // Almacena la respuesta de la tercera pregunta del título
  String? _plnateamientopregunta1; // Respuesta 1 del planteamiento
  String? _plnateamientopregunta2; // Respuesta 2 del planteamiento
  String? _plnateamientopregunta3; // Respuesta 3 del planteamiento
  String? _justificacionpregunta1; // Respuesta 1 de la justificación
  String? _justificacionpregunta2; // Respuesta 2 de la justificación
  String? _justificacionpregunta3; // Respuesta 3 de la justificación
  String? _objetivospregunta1; // Respuesta 1 de objetivos
  String? _objetivospregunta2; // Respuesta 2 de objetivos
  String? _objetivospregunta3; // Respuesta 3 de objetivos
  String? _metodologiapregunta1; // Respuesta 1 de metodología
  String? _metodologiapregunta2; // Respuesta 2 de metodología
  String? _metodologiapregunta3; // Respuesta 3 de metodología
  String? _cronogramapregunta1; // Respuesta 1 de cronograma
  String? _cronogramapregunta2; // Respuesta 2 de cronograma
  String? _cronogramapregunta3; // Respuesta 3 de cronograma
  String? _actiivadadespregunta1; // Respuesta 1 de actividades
  String? _actiivadadespregunta2; // Respuesta 2 de actividades
  String? _actiivadadespregunta3; // Respuesta 3 de actividades
  String? _bibliografiapregunta1; // Respuesta 1 de bibliografía
  String? _bibliografiapregunta2; // Respuesta 2 de bibliografía
  String? _bibliografiapregunta3; // Respuesta 3 de bibliografía

  // Controlador para el campo de texto de observaciones finales
  final TextEditingController _observaciontext = TextEditingController();

  // Construye una opción con RadioButton y texto
  Widget _buildOpcion({
    required String texto, // Texto visible para el usuario
    required String value, // Valor asignado a la opción
    required String? groupValue, // Valor actualmente seleccionado
    required Function(String?) onChanged, // Acción al cambiar la selección
  }) {
    return Row(
      // Alinea los elementos verticalmente al centro
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Botón de selección tipo Radio permite elegir una opción dentro de un mismo grupo
        Radio<String>(
          value: value, // Valor asociado a esta opción
          groupValue: groupValue, // Valor actualmente seleccionado
          onChanged: onChanged, // Acción al seleccionar la opción
        ),

        // Permite que el texto ocupe el espacio disponible
        Expanded(
          child: Text(
            texto, // Texto que se muestra al usuario
            style: const TextStyle(fontSize: 16), // Tamaño del texto
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbars(),
      drawer: Menu(
        currentScreen: 'Encuesta',
        progreso: ProgresoGlobal.porcentaje,
      ),
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
                                      onChanged: (val) => setState(
                                        () => _titulopregunta1 = val,
                                      ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'B) El título es importante porque es lo primero que se escribe.',
                                      value: 'B incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged: (val) => setState(
                                        () => _titulopregunta1 = val,
                                      ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'C) El título es importante porque identifica el proyecto.',
                                      value: 'correcto', //correcta
                                      groupValue: _titulopregunta1,
                                      onChanged: (val) => setState(
                                        () => _titulopregunta1 = val,
                                      ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'D) Porque todos los proyectos deben tener un título.',
                                      value: 'D incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _titulopregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) En promedio de 10 a 15 palabras.',
                                  value: 'B incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged: (val) => setState(
                                    () => _titulopregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) En promedio de 20 a 30 palabras.',
                                  value: 'C incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged: (val) => setState(
                                    () => _titulopregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) En promedio de 15 a 20 palabras.',
                                  value: 'D incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _titulopregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 5.',
                                  value: 'B incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged: (val) => setState(
                                    () => _titulopregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 6.',
                                  value: 'C incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged: (val) => setState(
                                    () => _titulopregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 3.',
                                  value: 'correcto',
                                  groupValue: _titulopregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _plnateamientopregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) 5WIH, Espina de pescado, Árbol de problemas, Esquema de redacción.',
                                  value: 'correcto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged: (val) => setState(
                                    () => _plnateamientopregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C)What, When, Where, How.',
                                  value: 'C incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged: (val) => setState(
                                    () => _plnateamientopregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Hipótesis,Cronograma, Objetivos, Conclusiones.',
                                  value: 'D incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged: (val) => setState(
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
                                      onChanged: (val) => setState(
                                        () => _plnateamientopregunta2 = val,
                                      ),
                                    ),
                                    _buildOpcion(
                                      texto: 'B) 4.',
                                      value: 'B incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged: (val) => setState(
                                        () => _plnateamientopregunta2 = val,
                                      ),
                                    ),
                                    _buildOpcion(
                                      texto: 'C) 5.',
                                      value: 'C incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged: (val) => setState(
                                        () => _plnateamientopregunta2 = val,
                                      ),
                                    ),
                                    _buildOpcion(
                                      texto: 'D) 6.',
                                      value: 'correcto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _plnateamientopregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Maquinaria, mano de obra, materiales, métodos, medio ambiente y medición.',
                                  value: 'correcto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged: (val) => setState(
                                    () => _plnateamientopregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Manejo, mensualidad, memoria, modelo, mercado y módulo.',
                                  value: 'C incorrecto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged: (val) => setState(
                                    () => _plnateamientopregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Meta, marco teórico, motivación, medios, misión y modelo.',
                                  value: 'D incorrecto',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Argumentar la problemática y describir la conveniencia.',
                                  value: 'correcto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Explicar únicamente los costos económicos.',
                                  value: 'C incorrecto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Hacer un resumen corto del proyecto.',
                                  value: 'D incorrecto',
                                  groupValue: _justificacionpregunta1,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 5',
                                  value: 'correcto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 6',
                                  value: 'C incorrecto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 7',
                                  value: 'D incorrecto',
                                  groupValue: _justificacionpregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) En segunda persona, para dirigirse al lector directamente.',
                                  value: 'B incorrecto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) En un lenguaje coloquial, para que sea más cercano.',
                                  value: 'C incorrecto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged: (val) => setState(
                                    () => _justificacionpregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) En tercera persona, para dar mayor seriedad e imparcialidad.',
                                  value: 'correcto',
                                  groupValue: _justificacionpregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) PURE.',
                                  value: 'B incorrecto',
                                  groupValue: _objetivospregunta1,
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) SMART.',
                                  value: 'correcto',
                                  groupValue: _objetivospregunta1,
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) CLEAR.',
                                  value: 'D incorrecto',
                                  groupValue: _objetivospregunta1,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Específico, Medible, Alcanzable, Relevante y en Tiempo.',
                                  value: 'correcto',
                                  groupValue: _objetivospregunta2,
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Sencillo, Motivador, Actual, Realista y Técnico.',
                                  value: 'C incorrecto',
                                  groupValue: _objetivospregunta2,
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Estratégico, Mínimo, Apropiado, Reducido y Tolerante.',
                                  value: 'D incorrecto',
                                  groupValue: _objetivospregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Evitar la búsqueda de soluciones paso a paso.',
                                  value: 'B incorrecto',
                                  groupValue: _objetivospregunta3,
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Plantear los pasos negativos del proyecto.',
                                  value: 'C incorrecto',
                                  groupValue: _objetivospregunta3,
                                  onChanged: (val) => setState(
                                    () => _objetivospregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Reunir información sin relación con el problema.',
                                  value: 'D incorrecto',
                                  groupValue: _objetivospregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Porque es un requisito sin relevancia.',
                                  value: 'B incorrecto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Porque solo sirve para justificar los resultados.',
                                  value: 'C incorrecto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Porque determina todo el rumbo de la investigación.',
                                  value: 'correcto',
                                  groupValue: _metodologiapregunta1,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 2.',
                                  value: 'B incorrecto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 3.',
                                  value: 'correcto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 4.',
                                  value: 'D incorrecto',
                                  groupValue: _metodologiapregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Los factores que influyen en la decisión, las metodologías que existen y los pasos para elegir la adecuada.',
                                  value: 'correcto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) El tiempo disponible para la investigación.',
                                  value: 'C incorrecto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged: (val) => setState(
                                    () => _metodologiapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Únicamente los resultados esperados.',
                                  value: 'D incorrecto',
                                  groupValue: _metodologiapregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Que elimina la necesidad de usar tecnología.',
                                  value: 'B incorrecto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Que hace innecesaria la organización del equipo.',
                                  value: 'C incorrecto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Que permite visualizar el trabajo en un cronograma de actividades en lugar de una lista desorganizada.',
                                  value: 'correcto',
                                  groupValue: _cronogramapregunta1,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Una idea clara de cómo encajan todas las piezas del plan.',
                                  value: 'correcto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) La posibilidad de trabajar sin estructura.',
                                  value: 'C incorrecto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Una reducción del tiempo de ejecución sin planificación.',
                                  value: 'D incorrecto',
                                  groupValue: _cronogramapregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Porque siempre depende del jefe del proyecto.',
                                  value: 'B incorrecto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Porque requiere demasiado presupuesto.',
                                  value: 'C incorrecto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged: (val) => setState(
                                    () => _cronogramapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Porque se necesita la tecnología adecuada.',
                                  value: 'correcto',
                                  groupValue: _cronogramapregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) Con el fin de registrar únicamente los costos.',
                                  value: 'B incorrecto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Con el fin de reemplazar el cronograma.',
                                  value: 'C incorrecto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Con el fin de eliminar los roles de ejecución.',
                                  value: 'D incorrecto',
                                  groupValue: _actiivadadespregunta1,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Uno.',
                                  value: 'correcto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) Dos.',
                                  value: 'C incorrecto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) Varios sin limites.',
                                  value: 'D incorrecto',
                                  groupValue: _actiivadadespregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Únicamente al final del proyecto.',
                                  value: 'B incorrecto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) En cualquier orden y sin límite de tiempo.',
                                  value: 'C incorrecto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged: (val) => setState(
                                    () => _actiivadadespregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) En el orden y período de tiempo en el cual se pretenden alcanzar.',
                                  value: 'correcto',
                                  groupValue: _actiivadadespregunta3,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Para llenar espacio.',
                                  value: 'B incorrecto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) Para confundir al lector.',
                                  value: 'C incorrecto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta1 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) Para cambiar la información.',
                                  value: 'D incorrecto',
                                  groupValue: _bibliografiapregunta1,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Normas Vancouver y Normas MLA.',
                                  value: 'B incorrecto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'C) Normas APA y Normas IEEE.',
                                  value: 'correcto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta2 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Normas ISO 14000 y Normas ICONTEC.',
                                  value: 'D incorrecto',
                                  groupValue: _bibliografiapregunta2,
                                  onChanged: (val) => setState(
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
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'B) Únicamente el año de publicación.',
                                  value: 'B incorrecto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'C) Su nombre y el año de publicación.',
                                  value: 'correcto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta3 = val,
                                  ),
                                ),
                                _buildOpcion(
                                  texto: 'D) Solo el título de la obra.',
                                  value: 'D incorrecto',
                                  groupValue: _bibliografiapregunta3,
                                  onChanged: (val) => setState(
                                    () => _bibliografiapregunta3 = val,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /* if (_titulopregunta1 != null &&
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
                            ),*/
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

  // Widget que construye la tarjeta donde el usuario escribe la observación final
  Widget _card(BuildContext context) {
    return Card(
      // Color de fondo de la tarjeta
      color: obtenercolor('Color_Fondo'),

      // Bordes redondeados de la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),

      // Elevación para dar efecto de sombra
      elevation: 4,

      child: Padding(
        // Espaciado interno de la tarjeta
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 20,
          left: 20,
          right: 20,
        ),

        child: Column(
          children: [
            // Campo de texto para que el usuario escriba su observación
            TextField(
              controller: _observaciontext, // Controla el texto ingresado
              decoration: InputDecoration(
                // Pregunta que se muestra como etiqueta
                labelText:
                    '¿Cómo fue su experiencia al usar el aplicativo y por qué?',

                // Estilo del texto de la etiqueta
                labelStyle: TextStyle(color: Colors.black),

                // Estilo del borde cuando el campo no está seleccionado
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),

                // Estilo del borde cuando el campo está seleccionado
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),

            // Espacio entre el campo de texto y el botón
            SizedBox(height: 20),

            SizedBox(
              height: 45,
              child: ElevatedButton(
                // Estilos del botón
                style: ElevatedButton.styleFrom(
                  backgroundColor: obtenercolor('Color_Principal'),
                  foregroundColor: obtenercolor('Color_Texto_Principal'),
                ),

                // Acción que se ejecuta al presionar el botón
                onPressed: () {
                  _respuesta(context);
                },

                // Texto del botón
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

  // Función que gestiona el envío de la respuesta escrita por el usuario
  // Se ejecuta al presionar el botón "Enviar Respuesta"
  void _respuesta(BuildContext context) async {
    // Obtiene el texto ingresado en el campo de observación
    // y elimina espacios innecesarios al inicio y al final
    final respuesta = _observaciontext.text.trim();

    // Envía la observación al servidor junto con los datos del usuario
    await enviarEncuesta(
      observacion: respuesta,
      nombre:
          usuarioglobal, // Nombre del usuario obtenido de la variable global
      ficha: fichaglobal, // Ficha del usuario obtenida de la variable global
    );

    // Muestra un mensaje emergente confirmando el envío de la respuesta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text("Muchas por su opinión 😊")),
        backgroundColor: obtenercolor('Color_Principal'),
      ),
    );

    // Limpia el campo de texto después de enviar la respuesta
    _observaciontext.clear();
  }

  // Widget que construye el botón final del cuestionario
  Widget _bonton(BuildContext context) {
    return ElevatedButton(
      // Estilos visuales del botón
      style: ElevatedButton.styleFrom(
        backgroundColor: obtenercolor('Color_Principal'),
        foregroundColor: obtenercolor('Color_Texto_Principal'),
      ),

      // Acción que se ejecuta al presionar el botón
      onPressed: () async {
        // Validación: verifica que todas las preguntas hayan sido respondidas
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
          // Muestra un mensaje de error si existen campos sin responder
          _mostrarcamposenblanco(
            context,
            'No puede haber campos en blanco',
          );

          // Detiene la ejecución si la validación falla
          return;
        } else {
          // Ejecuta la función principal asociada al botón
          _funcionboton(context);

          // Envía al servidor el número de intentos realizados
          await enviarintentos(
            nombre: usuarioglobal,
            ficha: fichaglobal,
            intentos: _intentos, // Envía el valor real de intentos
          );
        }
      },

      // Texto que se muestra en el botón
      child: Text(
        'Finalizar',
        style: TextStyle(fontSize: tamanotexto(2)),
      ),
    );
  }

  // Función que elimina todas las respuestas seleccionadas en el cuestionario
  // Se utiliza para reiniciar el estado de las preguntas
  void _eliminarrespuesta(BuildContext context) {
    // Actualiza el estado del widget
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
    // Variable que almacena el total de respuestas correctas
    int totalCorrectas = 0;

    // Lista que guarda el resultado individual de cada pregunta
    // Se utiliza para evaluar y mostrar el desempeño del usuario
    List<String> resultados = [];

    // Se verifica cada pregunta y se incrementa el contador
    // de respuestas correctas según corresponda.
    // Además, se guarda el resultado individual en la lista.
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

    // Calcula la nota final sobre 100
    // Se divide el total de respuestas correctas entre el total de preguntas
    double nota = (totalCorrectas / 24) * 100;

    // Muestra los resultados del cuestionario en un cuadro de diálogo
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // Color de fondo del diálogo
        backgroundColor: Colors.white,

        // Título del diálogo
        title: const Text("Resultados del Cuestionario"),

        // Contenido principal del diálogo con scroll
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Muestra el puntaje final obtenido
              Text(
                "Puntaje final: ${nota.toStringAsFixed(1)} / 100",
                style: TextStyle(
                  fontSize: tamanotexto(3),
                  fontFamily: 'Calibri',
                ),
              ),

              // Mensaje mostrado cuando el puntaje es perfecto
              if (nota == 100.0)
                Column(
                  children: [
                    Text(
                      'Felicidades',
                      style: TextStyle(
                        fontSize: tamanotexto(3),
                        fontFamily: 'Calibri',
                      ),
                    ),
                    Text(
                      "Respuestas correctas: $totalCorrectas de 24",
                      style: TextStyle(
                        fontSize: tamanotexto(3) - 6,
                        color: obtenercolor('Color_Principal'),
                      ),
                    ),
                  ],
                ),

              // Mensaje mostrado cuando el puntaje no es perfecto
              if (nota != 100.0)
                Text(
                  "Respuestas correctas: $totalCorrectas de 24",
                  style: TextStyle(
                    fontSize: tamanotexto(3) - 6,
                    color: Colors.red,
                    fontFamily: 'Calibri',
                  ),
                ),

              // Espaciado visual
              const SizedBox(height: 10),

              // Encabezado del detalle de preguntas
              Text("Detalle de preguntas:"),

              const SizedBox(height: 10),

              // Lista dinámica con el resultado de cada pregunta
              ...resultados
                  .map(
                    (r) => Text(
                      r,
                      style: TextStyle(fontSize: tamanotexto(2) - 3),
                    ),
                  )
                  // ignore: unnecessary_to_list_in_spreads
                  .toList(),
            ],
          ),
        ),

        // Acciones disponibles en el diálogo
        actions: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Botones alineados horizontalmente
              children: [
                // Botón que aparece solo si el puntaje es perfecto
                if (nota == 100)
                  TextButton(
                    onPressed: () {
                      // Limpia las respuestas seleccionadas
                      _eliminarrespuesta(context);

                      // Cierra el diálogo
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

                // Botón que aparece cuando el usuario no obtiene el puntaje completo
                if (nota <= 99.9)
                  TextButton(
                    onPressed: () async {
                      // Incrementa el número de intentos
                      setState(() {
                        _intentos += 1;
                      });

                      // Limpia las respuestas para un nuevo intento
                      _eliminarrespuesta(context);

                      // Cierra el diálogo
                      Navigator.of(ctx).pop();

                      // Envía al servidor el nuevo número de intentos
                      await enviarintentos(
                        nombre: usuarioglobal,
                        ficha: fichaglobal,
                        intentos: _intentos, // Envía el valor real
                      );
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
