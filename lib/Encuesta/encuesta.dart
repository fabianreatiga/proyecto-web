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

class _EncuestasState extends State<Encuestas> {
  // Variables de estado (sí/no) -> true = Sí, false = No
  bool? _diseno;
  bool? _facil;
  bool? _util;
  bool? _organizacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbar2(nombre: '', progreso: 100, actions: []),
      drawer: Menu(currentScreen: 'Encuesta'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Card(
              color: obtenercolor('Color_Fondo'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pregunta 1
                    Center(child: const Text('1. ¿Le gustó el diseño?')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _diseno,
                          onChanged: (value) {
                            setState(() => _diseno = value);
                          },
                        ),
                        const Text('Sí'),
                        Radio<bool>(
                          value: false,
                          groupValue: _diseno,
                          onChanged: (value) {
                            setState(() => _diseno = value);
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Pregunta 2
                    Center(
                      child: const Text(
                        '2. ¿Le resultó fácil de entender la información presentada?',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _facil,
                          onChanged: (value) {
                            setState(() => _facil = value);
                          },
                        ),
                        const Text('Sí'),
                        Radio<bool>(
                          value: false,
                          groupValue: _facil,
                          onChanged: (value) {
                            setState(() => _facil = value);
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Pregunta 3
                    Center(
                      child: const Text(
                        '3. ¿Considera que el contenido es útil?',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _util,
                          onChanged: (value) {
                            setState(() => _util = value);
                          },
                        ),
                        const Text('Sí'),
                        Radio<bool>(
                          value: false,
                          groupValue: _util,
                          onChanged: (value) {
                            setState(() => _util = value);
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Pregunta 4
                    Center(
                      child: const Text(
                        '4. ¿La organización del material le pareció adecuada?',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _organizacion,
                          onChanged: (value) {
                            setState(() => _organizacion = value);
                          },
                        ),
                        const Text('Sí'),
                        Radio<bool>(
                          value: false,
                          groupValue: _organizacion,
                          onChanged: (value) {
                            setState(() => _organizacion = value);
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Botón Enviar
                    Center(
                      child: SizedBox(
                        height: 45,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: obtenercolor('Color_Principal'),
                            foregroundColor: obtenercolor(
                              'Color_Texto_Principal',
                            ),
                          ),
                          onPressed: () {
                            // Aquí recoges las respuestas
                            print('Diseño: $_diseno');
                            print('Fácil de entender: $_facil');
                            print('Contenido útil: $_util');
                            print('Organización: $_organizacion');
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
    );
  }
}
