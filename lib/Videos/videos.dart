import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Menus/menus.dart';

// ignore: library_prefixes
import 'package:nuevomockups/global.dart' as ProgresoGlobal;

class Videos extends StatelessWidget {
  const Videos({super.key});

  @override
  Widget build(BuildContext context) {
    return Video();
  }
}

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    final bool esPantallaPequena =
        MediaQuery.of(context).size.shortestSide < 650;
    return Scaffold(
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbars(),
      drawer: Menu(currentScreen: 'Video', progreso: 100),
      body: Stack(
        children: [
          //fondo inferior derecha
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Video/Fondo_inferior_Derecha.png',
                width: esPantallaPequena ? 320 : 400,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          //fondo superior izquierda
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Video/Fondo_superior_Izqiuerda.png',
                width: esPantallaPequena ? 320 : 400,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Icono_video.png',
                width: esPantallaPequena ? 45 : 98,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Icono_video.png',
                width: esPantallaPequena ? 45 : 98,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // SizedBox(height: esPantallaPequena ? 50 : 100),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: esPantallaPequena ? 50 : 100,
                  left: 20,
                  right: 20,
                  bottom: esPantallaPequena ? 50 : 100,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  color: obtenercolor('Color_Fondo'),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: tamanotexto(2) + 4,
                              fontFamily: 'Calibri',
                              height: 1.5,
                              color: Colors.black,
                            ),
                            children: [
                              //---------------------- Video explicativo de Titulo ----------------------
                              TextSpan(
                                text: 'Título\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/F_MeeGwggHk',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Planteamiento del Problema ----------------------
                              TextSpan(
                                text: 'Planteamiento del Problema\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/dKs0BfuF25A',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Justificación ----------------------
                              TextSpan(
                                text: 'Justificación\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/GOU4qjxFNxw',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Objetivos ----------------------
                              TextSpan(
                                text: 'Objetivos\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/WwmEpjQ4knE',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Metodología ----------------------
                              TextSpan(
                                text: 'Metodología\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/BVo31Aun_fg',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Cronograma ----------------------
                              TextSpan(
                                text: 'Cronograma\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/L0WrJUFkRKs',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Actividades o resultados ----------------------
                              TextSpan(
                                text: 'Actividades o resultados\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/xJ4aDq4JUxU',
                                    );
                                  },
                              ),

                              //---------------------- Video explicativo de Bibliografía ----------------------
                              TextSpan(
                                text: 'Bibliografía\n',
                                style: TextStyle(
                                  fontSize: tamanotexto(1) - 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                              ),
                              TextSpan(
                                text: 'Video explicativo.\n\n',
                                style: TextStyle(
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/bHvl_wPp4a4',
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Appbars extends StatelessWidget implements PreferredSizeWidget {
  const Appbars({super.key});

  // todo este bloque es un appbar secuncundario que muestra el nombre del usuario y pero no el progreso

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //  Título principal
          Text(
            'Aplicativo para la estructuración de proyectos de investigación',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: tamanotexto(3),
              fontWeight: FontWeight.bold,
              color: obtenercolor('Color_Texto_Principal'),
            ),
          ),

          // Nombre de usuario + progreso
          Row(
            children: [
              Icon(
                Icons.person,
                size: tamanotexto(2) + 5,
                color: obtenercolor('Color_Texto_Principal'),
              ),

              const SizedBox(width: 10),

              // Aquí aparece el nombre dinámico
              Text(
                ProgresoGlobal.usuarioglobal,
                style: TextStyle(
                  fontFamily: 'Calibri',
                  fontSize: tamanotexto(2) + 2,
                  color: obtenercolor('Color_Texto_Principal'),
                ),
              ),

              const SizedBox(width: 20),
            ],
          ),
        ],
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
