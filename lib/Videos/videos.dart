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
    return Scaffold(
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbars(),
      drawer: Menu(currentScreen: 'Videos'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Card(
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20T%C3%ADtulo%2FVideo%20del%20t%C3%ADtulo%2Ewebm&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E14f8d0ee%2Dd03d%2D4c9a%2D9f61%2D041ab9840b25',
                                        );
                                      },
                              ),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20Planteamiento%20del%20problema%2FPlanteamiento%20del%20problema%20video%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E894d23f2%2Db0ea%2D4b47%2D9319%2D90cfdf5a7be2',
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20T%C3%ADtulo%2FVideo%20del%20t%C3%ADtulo%2Ewebm&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E14f8d0ee%2Dd03d%2D4c9a%2D9f61%2D041ab9840b25',
                                        );
                                      },
                              ),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20Planteamiento%20del%20problema%2FPlanteamiento%20del%20problema%20video%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E894d23f2%2Db0ea%2D4b47%2D9319%2D90cfdf5a7be2',
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20T%C3%ADtulo%2FVideo%20del%20t%C3%ADtulo%2Ewebm&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E14f8d0ee%2Dd03d%2D4c9a%2D9f61%2D041ab9840b25',
                                        );
                                      },
                              ),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20Planteamiento%20del%20problema%2FPlanteamiento%20del%20problema%20video%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E894d23f2%2Db0ea%2D4b47%2D9319%2D90cfdf5a7be2',
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
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
                              TextSpan(
                                text: 'Actividades o resultados\n\n',
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20T%C3%ADtulo%2FVideo%20del%20t%C3%ADtulo%2Ewebm&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E14f8d0ee%2Dd03d%2D4c9a%2D9f61%2D041ab9840b25',
                                        );
                                      },
                              ),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        abrirLink(
                                          'https://sena4-my.sharepoint.com/personal/ochaparrob_sena_edu_co/_layouts/15/stream.aspx?id=%2Fpersonal%2Fochaparrob%5Fsena%5Fedu%5Fco%2FDocuments%2F5%2E%20Sena%20Documentos%2F2025%2FInvestigaci%C3%B3n%2FProyecto%20Investigaci%C3%B3n%20Practica%2FVideo%20Planteamiento%20del%20problema%2FPlanteamiento%20del%20problema%20video%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E894d23f2%2Db0ea%2D4b47%2D9319%2D90cfdf5a7be2',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Appbars extends StatelessWidget implements PreferredSizeWidget {
  const Appbars({super.key});

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
