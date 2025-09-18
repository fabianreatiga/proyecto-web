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
  required String bibliografia,
  required String nombre,
  required String ficha,
}) async {
  final url = Uri.parse("http://192.168.0.103:5000/guardarTodo");

  final respuesta = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({     
      "bibliografia": bibliografia,
      "nombre": nombre,
      "ficha": ficha,
      //"fecha": DateTime.now().toIso8601String(),
    }),
  );

  if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
    throw Exception("Error al enviar encuesta: ${respuesta.body}");
  }
  debugPrint(
    "📤 Enviando: ${jsonEncode({"bibliografia": bibliografia, "nombre": nombre, "ficha": ficha})}",
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
  String? _titulo;
  String? _planteamientoproblema;
  String? _justificacion;
  String? _objetivos;
  String? _metodologia;
  String? _cronograma;
  String? _actividadesresultados;
  String? _bibliografia;

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
            child: Card(
              color: obtenercolor('Color_Fondo'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/fondo_textura_2.png'),
                        scale: 0.5,
                        opacity: 0.2,
                        alignment: Alignment.bottomLeft,
                        fit: BoxFit.none,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Preguntas (1 a 4) siguen igual
                        Text(
                          '1. ¿El contenido de Título le fue útil como apoyo en la estructuración de su proyecto de investigación?',
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
                                    texto: 'Muy útil',
                                    value: 'Muy útil',
                                    groupValue: _titulo,
                                    onChanged:
                                        (val) => setState(() => _titulo = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Útil',
                                    value: 'Útil',
                                    groupValue: _titulo,
                                    onChanged:
                                        (val) => setState(() => _titulo = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Poco útil',
                                    value: 'Poco útil',
                                    groupValue: _titulo,
                                    onChanged:
                                        (val) => setState(() => _titulo = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Nada útil',
                                    value: 'Nada útil',
                                    groupValue: _titulo,
                                    onChanged:
                                        (val) => setState(() => _titulo = val),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '2. ¿Considera que las orientaciones en la sección Planteamiento del problema fueron claras y útiles para su proyecto?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Totalmente de acuerdo',
                                value: 'Totalmente de acuerdo',
                                groupValue: _planteamientoproblema,
                                onChanged:
                                    (val) => setState(
                                      () => _planteamientoproblema = val,
                                    ),
                              ),
                              _buildOpcion(
                                texto: 'De acuerdo',
                                value: 'De acuerdo',
                                groupValue: _planteamientoproblema,
                                onChanged:
                                    (val) => setState(
                                      () => _planteamientoproblema = val,
                                    ),
                              ),
                              _buildOpcion(
                                texto: 'En desacuerdo',
                                value: 'En desacuerdo',
                                groupValue: _planteamientoproblema,
                                onChanged:
                                    (val) => setState(
                                      () => _planteamientoproblema = val,
                                    ),
                              ),
                              _buildOpcion(
                                texto: 'Totalmente en desacuerdo',
                                value: 'Totalmente en desacuerdo',
                                groupValue: _planteamientoproblema,
                                onChanged:
                                    (val) => setState(
                                      () => _planteamientoproblema = val,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '3. ¿La justificación logra demostrar el impacto positivo que tendría el proyecto?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Totalmente de acuerdo',
                                value: 'Totalmente de acuerdo',
                                groupValue: _justificacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _justificacion = val),
                              ),
                              _buildOpcion(
                                texto: 'De acuerdo',
                                value: 'De acuerdo',
                                groupValue: _justificacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _justificacion = val),
                              ),
                              _buildOpcion(
                                texto: 'En desacuerdo',
                                value: 'En desacuerdo',
                                groupValue: _justificacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _justificacion = val),
                              ),
                              _buildOpcion(
                                texto: 'Totalmente en desacuerdo',
                                value: 'Totalmente en desacuerdo',
                                groupValue: _justificacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _justificacion = val),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '4. ¿Los objetivos están redactados de manera clara y fácil de comprender?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Excelente',
                                value: 'Excelente',
                                groupValue: _objetivos,
                                onChanged:
                                    (val) => setState(() => _objetivos = val),
                              ),
                              _buildOpcion(
                                texto: 'Bueno',
                                value: 'Bueno',
                                groupValue: _objetivos,
                                onChanged:
                                    (val) => setState(() => _objetivos = val),
                              ),
                              _buildOpcion(
                                texto: 'Regular',
                                value: 'Regular',
                                groupValue: _objetivos,
                                onChanged:
                                    (val) => setState(() => _objetivos = val),
                              ),
                              _buildOpcion(
                                texto: 'Malo',
                                value: 'Malo',
                                groupValue: _objetivos,
                                onChanged:
                                    (val) => setState(() => _objetivos = val),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '5. ¿La metodología propuesta es clara en cuanto a los pasos o etapas que se seguirán?',
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
                                    texto: 'Muy satisfecho',
                                    value: 'Muy satisfecho',
                                    groupValue: _metodologia,
                                    onChanged:
                                        (val) =>
                                            setState(() => _metodologia = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Satisfecho',
                                    value: 'Satisfecho',
                                    groupValue: _metodologia,
                                    onChanged:
                                        (val) =>
                                            setState(() => _metodologia = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Insatisfecho',
                                    value: 'Insatisfecho',
                                    groupValue: _metodologia,
                                    onChanged:
                                        (val) =>
                                            setState(() => _metodologia = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Muy insatisfecho',
                                    value: 'Muy insatisfecho',
                                    groupValue: _metodologia,
                                    onChanged:
                                        (val) =>
                                            setState(() => _metodologia = val),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '6. ¿El cronograma refleja un uso eficiente del tiempo para cumplir con las actividades?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Totalmente de acuerdo',
                                value: 'Totalmente de acuerdo',
                                groupValue: _cronograma,
                                onChanged:
                                    (val) => setState(() => _cronograma = val),
                              ),
                              _buildOpcion(
                                texto: 'De acuerdo',
                                value: 'De acuerdo',
                                groupValue: _cronograma,
                                onChanged:
                                    (val) => setState(() => _cronograma = val),
                              ),
                              _buildOpcion(
                                texto: 'En desacuerdo',
                                value: 'En desacuerdo',
                                groupValue: _cronograma,
                                onChanged:
                                    (val) => setState(() => _cronograma = val),
                              ),
                              _buildOpcion(
                                texto: 'Totalmente en desacuerdo',
                                value: 'Totalmente en desacuerdo',
                                groupValue: _cronograma,
                                onChanged:
                                    (val) => setState(() => _cronograma = val),
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
                        const SizedBox(height: 30),

                        // Botón Enviar
                        Center(
                          child: SizedBox(
                            height: 45,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: obtenercolor(
                                  'Color_Principal',
                                ),
                                foregroundColor: obtenercolor(
                                  'Color_Texto_Principal',
                                ),
                              ),
                              onPressed: () async {
                                if (_titulo == null ||
                                    _planteamientoproblema == null ||
                                    _justificacion == null ||
                                    _objetivos == null ||
                                    _metodologia == null ||
                                    _cronograma == null ||
                                    _actividadesresultados == null ||
                                    _bibliografia == null) {
                                  _mostrarcamposenblanco(
                                    context,
                                    'No puede haber campos en blanco',
                                  );
                                  return;
                                }

                                {
                                  //qiotar
                                  await enviarEncuesta(
                                    
                                    bibliografia: _bibliografia!,
                                    nombre: usuarioglobal,
                                    ficha: fichaglobal,
                                  ); //quitar

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(
                                          "Encuesta enviada correctamente",
                                        ),
                                      ),
                                      backgroundColor: obtenercolor(
                                        'Color_Principal',
                                      ),
                                    ),
                                  );

                                  setState(() {
                                    _titulo = null;
                                    _planteamientoproblema = null;
                                    _justificacion = null;
                                    _objetivos = null;
                                    _metodologia = null;
                                    _cronograma = null;
                                    _actividadesresultados = null;
                                    _bibliografia = null;
                                  });
                                }
                              },
                              child: Text(
                                'Enviar',
                                style: TextStyle(fontSize: tamanotexto(2)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
