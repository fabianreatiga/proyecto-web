// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Menus/menus.dart';

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
  // Variables de estado
  String? _diseno;
  String? _facil;
  String? _util;
  String? _organizacion;

  /// Widget para construir cada opción (Radio + Texto al lado alineados)
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
                        // Pregunta 1
                        Text(
                          '1. ¿Le gustó el diseño?',
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
                                    value: 'muy_satisfecho',
                                    groupValue: _diseno,
                                    onChanged:
                                        (val) => setState(() => _diseno = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Satisfecho',
                                    value: 'satisfecho',
                                    groupValue: _diseno,
                                    onChanged:
                                        (val) => setState(() => _diseno = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Insatisfecho',
                                    value: 'insatisfecho',
                                    groupValue: _diseno,
                                    onChanged:
                                        (val) => setState(() => _diseno = val),
                                  ),
                                  _buildOpcion(
                                    texto: 'Muy insatisfecho',
                                    value: 'muy_insatisfecho',
                                    groupValue: _diseno,
                                    onChanged:
                                        (val) => setState(() => _diseno = val),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Pregunta 2
                        Text(
                          '2. ¿Le resultó fácil de entender la información presentada?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Totalmente de acuerdo',
                                value: 'Totalmente de acuerdo',
                                groupValue: _facil,
                                onChanged:
                                    (val) => setState(() => _facil = val),
                              ),
                              _buildOpcion(
                                texto: 'De acuerdo',
                                value: 'De acuerdo',
                                groupValue: _facil,
                                onChanged:
                                    (val) => setState(() => _facil = val),
                              ),
                              _buildOpcion(
                                texto: 'En desacuerdo',
                                value: 'En desacuerdo',
                                groupValue: _facil,
                                onChanged:
                                    (val) => setState(() => _facil = val),
                              ),
                              _buildOpcion(
                                texto: 'Totalmente en desacuerdo',
                                value: 'Totalmente en desacuerdo',
                                groupValue: _facil,
                                onChanged:
                                    (val) => setState(() => _facil = val),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Pregunta 3
                        Text(
                          '3. ¿Considera que el contenido es útil?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Totalmente de acuerdo',
                                value: 'Totalmente de acuerdo',
                                groupValue: _util,
                                onChanged: (val) => setState(() => _util = val),
                              ),
                              _buildOpcion(
                                texto: 'De acuerdo',
                                value: 'De acuerdo',
                                groupValue: _util,
                                onChanged: (val) => setState(() => _util = val),
                              ),
                              _buildOpcion(
                                texto: 'En desacuerdo',
                                value: 'En desacuerdo',
                                groupValue: _util,
                                onChanged: (val) => setState(() => _util = val),
                              ),
                              _buildOpcion(
                                texto: 'Totalmente en desacuerdo',
                                value: 'Totalmente en desacuerdo',
                                groupValue: _util,
                                onChanged: (val) => setState(() => _util = val),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Pregunta 4
                        Text(
                          '4. ¿La organización del material le pareció adecuada?',
                          style: TextStyle(fontSize: tamanotexto(2)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildOpcion(
                                texto: 'Excelente',
                                value: 'Excelente',
                                groupValue: _organizacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _organizacion = val),
                              ),
                              _buildOpcion(
                                texto: 'Bueno',
                                value: 'Bueno',
                                groupValue: _organizacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _organizacion = val),
                              ),
                              _buildOpcion(
                                texto: 'Regular',
                                value: 'Regular',
                                groupValue: _organizacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _organizacion = val),
                              ),
                              _buildOpcion(
                                texto: 'Malo',
                                value: 'Malo',
                                groupValue: _organizacion,
                                onChanged:
                                    (val) =>
                                        setState(() => _organizacion = val),
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
                              onPressed: () {
                                if (_diseno == null ||
                                    _facil == null ||
                                    _util == null ||
                                    _organizacion == null) {
                                  _mostrarcamposenblanco(
                                    context,
                                    'No puede haber campos en blanco',
                                  );
                                  return;
                                }

                                setState(() {
                                  _diseno = null;
                                  _facil = null;
                                  _util = null;
                                  _organizacion = null;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Center(
                                      child: Text("Respuestas enviadas"),
                                    ),
                                    backgroundColor: obtenercolor(
                                      'Color_Principal',
                                    ),
                                  ),
                                );
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
