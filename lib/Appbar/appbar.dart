import 'package:flutter/material.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/global.dart';
//import 'package:nuevomockups/global.dart';

// AppBar personalizado que muestra el título del aplicativo,
// el nombre del usuario, el progreso general y acciones dinámicas
class Appbar2 extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  // Valor de progreso que se muestra en la barra inferior
  final double progreso;

  // Nombre del usuario que se visualiza en el AppBar
  final String nombre;

  const Appbar2({
    super.key,
    required this.actions,
    required this.progreso,
    required this.nombre,
  }); // Aquí se reciben las acciones, el progreso y el nombre del usuario

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título principal del aplicativo
          Text(
            'Aplicativo para la estructuración de proyectos de investigación',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: tamanotexto(3),
              fontWeight: FontWeight.bold,
              color: obtenercolor('Color_Texto_Principal'),
            ),
          ),

          // Fila que muestra el nombre del usuario y el porcentaje de progreso
          Row(
            children: [
              Icon(
                Icons.person,
                size: tamanotexto(2) + 5,
                color: obtenercolor('Color_Texto_Principal'),
              ),

              const SizedBox(width: 10),

              // Nombre del usuario mostrado de forma dinámica
              Text(
                usuarioglobal,
                style: TextStyle(
                  fontFamily: 'Calibri',
                  fontSize: tamanotexto(2) + 2,
                  color: obtenercolor('Color_Texto_Principal'),
                ),
              ),

              const SizedBox(width: 20),

              // Porcentaje de progreso global del usuario
              Text(
                '${(ProgresoGlobal.progreso * 100).toInt()}%',
                style: TextStyle(
                  fontSize: tamanotexto(2),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),

      // Acciones personalizadas que se inyectan desde cada pantalla
      actions: actions,

      // Barra inferior que muestra visualmente el progreso del usuario
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Stack(
          children: [
            LinearProgressIndicator(
              minHeight: 9,
              value: progreso,
              valueColor: const AlwaysStoppedAnimation(
                Color.fromRGBO(80, 229, 249, 1),
              ),
              backgroundColor: Colors.grey[300],
            ),
          ],
        ),
      ),

      backgroundColor: obtenercolor('Color_Principal'),
      iconTheme: IconThemeData(color: obtenercolor('Color_Texto_Principal')),
      foregroundColor: obtenercolor('Color_Texto_Principal'),

      // Fondo decorativo con textura para el AppBar
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: obtenercolor('Color_Principal'),
          image: const DecorationImage(
            image: AssetImage('assets/fondo_textura.png'),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
      ),
    );
  }

  // Define la altura personalizada del AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 15);
}

// Este AppBar se reutiliza en todas las ventanas del aplicativo
