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
  String? _actividadesresultados;
  String? _bibliografia;

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
                                          'A) El título es importante porque contiene todos los objetivos específicos del proyecto',
                                      value: 'A incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'B) El título es importante porque es lo primero que se escribe',
                                      value: 'B incorrecto',
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'C) El título es importante porque identifica el proyecto',
                                      value: 'C Correcto', //correcta
                                      groupValue: _titulopregunta1,
                                      onChanged:
                                          (val) => setState(
                                            () => _titulopregunta1 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto:
                                          'D) Porque todos los proyectos deben tener un título',
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
                                  texto: 'A) En promedio de 12 a 20 palabras',
                                  value: 'A Correcto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) En promedio de 10 a 15 palabras',
                                  value: 'B incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) En promedio de 20 a 30 palabras',
                                  value: 'C incorrecto',
                                  groupValue: _titulopregunta2,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta2 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) En promedio de 15 a 20 palabras',
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
                                  texto: 'A) 7',
                                  value: 'A incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'B) 5',
                                  value: 'B incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C) 6',
                                  value: 'C incorrecto',
                                  groupValue: _titulopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _titulopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'D) 3',
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
                                  texto: 'A) Clear, Smart, Pure, Grow',
                                  value: 'A incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'B) 5WIH, Espina de pesacado, Árbol de problemas, Esquema de redacción',
                                  value: 'B correcto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'C)What, When, Where, How',
                                  value: 'C incorrecto',
                                  groupValue: _plnateamientopregunta1,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta1 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto:
                                      'D) Hipótesis,Cronograma, Objetivos, Conclusiones',
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
                                      texto: 'A) 3',
                                      value: 'A incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto: 'B) 4',
                                      value: 'B incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto: 'C) 5',
                                      value: 'C incorrecto',
                                      groupValue: _plnateamientopregunta2,
                                      onChanged:
                                          (val) => setState(
                                            () => _plnateamientopregunta2 = val,
                                          ),
                                    ),
                                    _buildOpcion(
                                      texto: 'D) 6',
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
                                  texto: 'Totalmente de acuerdo',
                                  value: 'Totalmente de acuerdo',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'De acuerdo',
                                  value: 'De acuerdo',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'En desacuerdo',
                                  value: 'En desacuerdo',
                                  groupValue: _plnateamientopregunta3,
                                  onChanged:
                                      (val) => setState(
                                        () => _plnateamientopregunta3 = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'Totalmente en desacuerdo',
                                  value: 'Totalmente en desacuerdo',
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
                            '7. ¿Los resultados esperados le parecen útiles y aplicables en la práctica?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'Totalmente de acuerdo',
                                  value: 'Totalmente de acuerdo',
                                  groupValue: _actividadesresultados,
                                  onChanged:
                                      (val) => setState(
                                        () => _actividadesresultados = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'De acuerdo',
                                  value: 'De acuerdo',
                                  groupValue: _actividadesresultados,
                                  onChanged:
                                      (val) => setState(
                                        () => _actividadesresultados = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'En desacuerdo',
                                  value: 'En desacuerdo',
                                  groupValue: _actividadesresultados,
                                  onChanged:
                                      (val) => setState(
                                        () => _actividadesresultados = val,
                                      ),
                                ),
                                _buildOpcion(
                                  texto: 'Totalmente en desacuerdo',
                                  value: 'Totalmente en desacuerdo',
                                  groupValue: _actividadesresultados,
                                  onChanged:
                                      (val) => setState(
                                        () => _actividadesresultados = val,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '8. ¿La bibliografía citada contribuye de forma clara a sustentar los contenidos del proyecto?',
                            style: TextStyle(fontSize: tamanotexto(2)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                _buildOpcion(
                                  texto: 'Excelente',
                                  value: 'Excelente',
                                  groupValue: _bibliografia,
                                  onChanged:
                                      (val) =>
                                          setState(() => _bibliografia = val),
                                ),
                                _buildOpcion(
                                  texto: 'Bueno',
                                  value: 'Bueno',
                                  groupValue: _bibliografia,
                                  onChanged:
                                      (val) =>
                                          setState(() => _bibliografia = val),
                                ),
                                _buildOpcion(
                                  texto: 'Regular',
                                  value: 'Regular',
                                  groupValue: _bibliografia,
                                  onChanged:
                                      (val) =>
                                          setState(() => _bibliografia = val),
                                ),
                                _buildOpcion(
                                  texto: 'Malo',
                                  value: 'Malo',
                                  groupValue: _bibliografia,
                                  onChanged:
                                      (val) =>
                                          setState(() => _bibliografia = val),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          if (_bibliografia != null)
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
        _actividadesresultados == null ||
        _bibliografia == null) {
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
                if (_titulopregunta1 == 'Muy útil') Text('ok'),
                if (_actividadesresultados == 'Totalmente de acuerdo')
                  Text('ok'),
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
      _actividadesresultados = null;
      _bibliografia = null;
    });
  }
}
