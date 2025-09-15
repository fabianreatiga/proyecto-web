import 'package:flutter/material.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/global.dart';
//import 'package:nuevomockups/global.dart';

class Appbar2 extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final double progreso; // <- Añadido
  final String nombre; // 👈 añadimos el nombre

  const Appbar2({
    super.key,
    required this.actions,
    required this.progreso,
    required this.nombre, // 👈 requerido
  }); // aca se recibe el nombre, progreso y las acciones

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Título principal
          Text(
            'Aplicativo para la estructuración de proyectos de investigación',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: tamanotexto(3),
              fontWeight: FontWeight.bold,
              color: obtenercolor('Color_Texto_Principal'),
            ),
          ),

          // 🔹 Nombre de usuario + progreso
          Row(
            children: [
              Icon(
                Icons.person,
                size: tamanotexto(2) + 5,
                color: obtenercolor('Color_Texto_Principal'),
              ),

              const SizedBox(width: 10),

              // 👤 Aquí aparece el nombre dinámico
              Text(
                usuarioglobal,
                style: TextStyle(
                  fontFamily: 'Calibri',
                  fontSize: tamanotexto(2) + 2,
                  color: obtenercolor('Color_Texto_Principal'),
                ),
              ),

              const SizedBox(width: 20),

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
      actions: actions,

      // 🔹 Barra inferior de progreso
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

      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: obtenercolor('Color_Principal'),
          image: const DecorationImage(
            image: AssetImage('assets/fondo_textura.png'),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        // aca tambien agregamos una textura
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 15); // se usa para ajustar el tamaño del appbar
}


// el appbar.dart se esta usando en todas las ventanas del aplicativo