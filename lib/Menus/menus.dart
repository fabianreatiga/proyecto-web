import 'package:flutter/material.dart';
import 'package:nuevomockups/Actividades/actividades.dart';
import 'package:nuevomockups/Bases_Datos/bases_datos.dart';
import 'package:nuevomockups/Bibliografia/bibliografia.dart';
import 'package:nuevomockups/Busqueda/busqueda.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Cronograma/cronograma.dart';
import 'package:nuevomockups/Encuesta/Encuesta.dart';
import 'package:nuevomockups/Justificacion/justificacion.dart';
import 'package:nuevomockups/Metodologia/metodologia.dart';
import 'package:nuevomockups/Objetivos/objetivos.dart';
import 'package:nuevomockups/PlanteamientoProblemas/plantiamientoproblemas.dart';
import 'package:nuevomockups/Titulo/titulo.dart';
import 'package:nuevomockups/main.dart';

class Menu extends StatelessWidget {
  final String
  currentScreen; // Pantalla actual para resaltar el ítem seleccionado

  const Menu({super.key, required this.currentScreen});

  get db => null;

  @override
  Widget build(BuildContext context) {
    const double texto = 14; // Tamaño base para el texto del menú

    return Drawer(
      backgroundColor: obtenercolor('Color_principal'),
      child: ListView(
        children: [
          //======================= ENCABEZADO MENÚ =======================\\
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  obtenercolor('Color_Principal'),
                  obtenercolor('Color_Principal'),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Menú Principal',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          //======================= OPCIÓN TITULO =======================\\
          ListTile(
            leading: Icon(
              Icons.title,
              color: currentScreen == 'Titulo' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Titulo',
              style: TextStyle(
                fontSize: texto + 4,
                color: currentScreen == 'Titulo' ? Colors.white : Colors.black,
              ),
            ),
            selected: currentScreen == 'Titulo',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Titulo()),
              );
            },
          ),
          //======================= OPCIÓN PLANTEAMIENTO DEL PROBLEMA =======================\\
          ListTile(
            leading: Icon(
              Icons.psychology,
              color:
                  currentScreen == 'PlantiamientoProblema'
                      ? Colors.white
                      : Colors.black,
            ),
            title: Text(
              'Planteamiento del Problema',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'PlantiamientoProblema'
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            selected: currentScreen == 'PlantiamientoProblema',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Plantiamientoproblemas(),
                ),
              );
            },
          ),
          //======================= OPCIÓN JUSTIFICACIÓN =======================\\
          ListTile(
            leading: Icon(
              Icons.fact_check,
              color:
                  currentScreen == 'Justificacion'
                      ? Colors.white
                      : Colors.black,
            ),
            title: Text(
              'Justificación',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Justificacion'
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            selected: currentScreen == 'Justificacion',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Justificacion()),
              );
            },
          ),
          //======================= OPCIÓN OBJETIVOS =======================\\
          ListTile(
            leading: Icon(
              Icons.flag,
              color: currentScreen == 'Objetivos' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Objetivos',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Objetivos' ? Colors.white : Colors.black,
              ),
            ),
            selected: currentScreen == 'Objetivos',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Objetivos()),
              );
            },
          ),
          //======================= OPCIÓN METODOLOGÍA =======================\\
          ListTile(
            leading: Icon(
              Icons.analytics,
              color:
                  currentScreen == 'Metodologia' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Metodología',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Metodologia'
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            selected: currentScreen == 'Metodologia',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Metodologia()),
              );
            },
          ),
          //======================= OPCIÓN CRONOGRAMA =======================\\
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color:
                  currentScreen == 'Cronograma' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Cronograma',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Cronograma' ? Colors.white : Colors.black,
              ),
            ),
            selected: currentScreen == 'Cronograma',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cronograma()),
              );
            },
          ),
          //======================= OPCIÓN ACTIVIDADES O RESULTADOS =======================\\
          ListTile(
            leading: Icon(
              Icons.task,
              color:
                  currentScreen == 'Actividades' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Actividades o resultados',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Actividades'
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            selected: currentScreen == 'Actividades',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Actividades()),
              );
            },
          ),
          //======================= OPCIÓN BIBLIOGRAFÍA =======================\\
          ListTile(
            leading: Icon(
              Icons.menu_book,
              color:
                  currentScreen == 'Bibliogafia' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Bibliografia',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Bibliogafia'
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            selected: currentScreen == 'Bibliogafia',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Bibliografia()),
              );
            },
          ),

          //========================== BUSQUEDA  =========================\\
          ListTile(
            leading: Icon(
              Icons.search,
              color: currentScreen == 'Busqueda' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Busqueda',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Busqueda' ? Colors.white : Colors.black,
              ),
            ),
            selected: currentScreen == 'Busqueda',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Busqueda()),
              );
            },
          ),

          //======================= BASES DE DATOS =======================\\
          ListTile(
            leading: Icon(
              Icons.storage,
              color:
                  currentScreen == 'BaseDeDatos' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Base de Datos Científica',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'BaseDeDatos'
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            selected: currentScreen == 'BaseDeDatos',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Basesdatos()),
              );
            },
          ),

          //======================= OPCIÓN ENCUESTA =======================\\
          ListTile(
            leading: Icon(
              Icons.check_circle,
              color: currentScreen == 'Encuesta' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Cuestionario',
              style: TextStyle(
                fontSize: texto + 4,
                color:
                    currentScreen == 'Encuesta' ? Colors.white : Colors.black,
              ),
            ),
            selected: currentScreen == 'Encuesta',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Encuesta()),
              );
            },
          ),
          //======================= OPCIÓN INICIO =======================\\
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: currentScreen == 'Inicio' ? Colors.white : Colors.black,
            ),
            title: Text(
              'Cerrar Sesión',
              style: TextStyle(
                fontSize: texto + 4,
                color: currentScreen == 'Inicio' ? Colors.white : Colors.black,
              ),
            ),
            selected: currentScreen == 'Inicio',
            selectedTileColor: obtenercolor('Color_Principal'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Inicio()),
                //MaterialPageRoute(builder: (context) => Inicio(db: db)),
              );
            },
          ),
        ],
      ),
    );
  }
}

//=======================================================================================================================================================================\\
