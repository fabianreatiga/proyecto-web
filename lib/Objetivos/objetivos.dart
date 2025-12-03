// ignore_for_file: unused_field, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Justificacion/justificacion.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/Metodologia/metodologia.dart';

import 'package:nuevomockups/global.dart';

class Objetivos extends StatelessWidget {
  const Objetivos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Objetivo(),
    );
  }
}

class Objetivo extends StatefulWidget {
  const Objetivo({super.key});

  @override
  State<Objetivo> createState() => _ObjetivoState();
}

class _ObjetivoState extends State<Objetivo> with TickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;
  final List<int> pestanasVistas = [];

  final List<String> textos = [
    'Hay varias formas de establecer objetivos, siendo una de las más utilizadas y populares la metodología SMART. Sin embargo, surgen nuevas propuestas metodológicas en el establecimiento de los objetivos desde otras perspectivas más globales o transversales, adaptándose a las diferentes filosofías y formas de trabajo empresarial y el entorno VUCA de la sociedad actual. En todos los casos, pero hay unos elementos comunes, los cuales son:',

    '',
    /* 'El modelo SMART –acrónimo que significa «inteligente» en inglés– hace referencia a cinco conceptos que hay'
        ' que tener presentes constantemente a la hora de fijar objetivos si lo que buscamos es validar su pertinencia.'
        ' Por orden, los conceptos son «específico» (S, specific), «medible» (M, measurable), «asignable» (A, assignable),'
        ' «realista» (R, realistic), «temporal» (T, time-related), es decir, determinado en el tiempo. Según Steffens, G.,'
        ' & Cadiat, A. C. (2016). Los criterios SMART: El método para fijar objetivos con éxito. 50Minutos.',*/
    'Esta metodología se basa en que el logro de un objetivo debe suponer un esfuerzo para que este sea relevante. Además,'
        ' incorpora nuevos elementos poco frecuentes hasta el momento en el planteamiento de objetivos tales como la legalidad o'
        ' el impacto en el medio ambiente. Según: https://www.itik.cat/uploads/files/5%20m%C3%A9todos %20para%20establecer%20objetivos.pdf',

    'La responsabilidad social y ética en las organizaciones cada vez está más presente en las estrategias de futuro,'
        ' y la metodología PURE se focaliza en la ética y relevancia de la concreción de los objetivos. Los elementos clave son:'
        ' • Positive stated (enunciados en positivo) • Understood (comprensible) • Relevant (relevante) • Ethical (ético)..',

    'Esta metodología propone una revisión del contexto en el que se definen los objetivos de una organización o de un proyecto'
        ' específico. Establece que el deseo y el compromiso son elementos indispensables para el logro de las metas propuestas asociando'
        ' también este camino a un crecimiento personal y profesional. • Goal (meta) • Reality (realidad)• Options (opciones)• Will (deseo).',

    'La metodología DUMB resalta las características que debe tener un objetivo de negocio. DUMB significa: Doable, Understandable, Manejable'
        ' y Beneficial. En traducción sería que cada objetivo tiene que ser realizable, entendible, manejable y beneficioso. Deben ser aquellos que'
        ' entreguen valor a la empresa y a la marca.',

    'El árbol de objetivos reúne los medios y alternativas para solucionar el problema principal. Gracias a ello, se logra una visión positiva de las'
        ' situaciones negativas que aparecían en el árbol anterior, aunque utilice la misma estructura. Así, se busca ir resolviendo el problema paso a paso.\n',
  ];

  final List<String> imagenes = [
    'assets/Objetivos/Objetivos.png', //COMO CREAR LOS OBJETIVOS
    'assets/Objetivos/Objetivos_Método_Smart_Texto.png', //MÉTODO SMART
    'assets/Objetivos/Objetivos_Método_Clear_Texto.png', //MÉTODO CLEAR
    'assets/Objetivos/Objetivos_Método_Pure.png', //MÉTODO PURE
    'assets/Objetivos/Objetivos_Método_Grow.png', //MÉTODO GROW
    'assets/Objetivos/Objetivos_Método_Dumb_texto.png', //MÉTODO DUMB
    'assets/Objetivos/Objetivos_Arbol_de_Objetivos.png', //ÁRBOL DE OJETIVOS
  ];

  final List<String> secciones = [
    'COMO CREAR LOS OBJETIVOS',
    'MÉTODO SMART',
    'MÉTODO CLEAR',
    'MÉTODO PURE',
    'MÉTODO GROW',
    'MÉTODO DUMB',
    'ÁRBOL DE OJETIVOS',
  ];

  /* int _progresoContador = 1;
  double get progreso {
    return _progresoContador / secciones.length;
  }*/

  List<double> grande(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.4 - 18, //COMO CREAR LOS OBJETIVOS
      MediaQuery.of(context).size.width * 0.18 - 18, //MÉTODO SMART
      MediaQuery.of(context).size.width * 0.1 - 18, //MÉTODO CLEAR
      MediaQuery.of(context).size.width * 0.3 - 18, //MÉTODO PURE
      MediaQuery.of(context).size.width * 0.14 - 18, //MÉTODO GROW
      MediaQuery.of(context).size.width * 0.1 - 18, //MÉTODO DUMB
      MediaQuery.of(context).size.width * 0.35 - 18, //ÁRBOL DE OJETIVOS
    ];
  }

  List<double> Pequena(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.6 - 18, //COMO CREAR LOS OBJETIVOS
      MediaQuery.of(context).size.width * 0.3 - 18, //MÉTODO SMART
      MediaQuery.of(context).size.width * 0.15 - 18, //MÉTODO CLEAR
      MediaQuery.of(context).size.width * 0.4 - 18, //MÉTODO PURE
      MediaQuery.of(context).size.width * 0.25 - 18, //MÉTODO GROW
      MediaQuery.of(context).size.width * 0.15 - 18, //MÉTODO DUMB
      MediaQuery.of(context).size.width * 0.55 - 18, //ÁRBOL DE OJETIVOS
    ];
  }

  static int ID_BASE_PROGRESO = 25;
  int _currentseccion = 0;

  @override
  void initState() {
    super.initState();

    pestanasVistas.add(0);
    // Marca la primera pestaña vista con el ID base definido:
    ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + 0);

    _tabController = TabController(length: secciones.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _index = _tabController.index);
        if (!pestanasVistas.contains(_tabController.index)) {
          pestanasVistas.add(_tabController.index);
          ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + _tabController.index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 📌 Ahora el nombre refleja la condición real
    final bool esPantallaPequena =
        MediaQuery.of(context).size.shortestSide < 650;

    return Scaffold(
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbar2(
        nombre: '',
        progreso: ProgresoGlobal.progreso,
        actions: [
          TextButton.icon(
            onPressed: () {
              modalmenu(context);
            },
            icon: Icon(
              Icons.more_vert,
              size: tamanotexto(3),
              color: obtenercolor('Color_Texto_Principal'),
            ),
            label: Text(
              'Ver más',
              style: TextStyle(
                color: obtenercolor('Color_Texto_Principal'),
                fontSize: tamanotexto(2),
              ),
            ),
          ),
        ],
      ),
      drawer: const Menu(currentScreen: 'Objetivos'),
      body: Stack(
        children: [
          // 🌄 Fondo superior izquierda decorativo
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Objetivos/Fondo_superior_Derecha.png',
                width: esPantallaPequena ? 120 : 250,
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
                'assets/Icono_Proveta.png',
                width: esPantallaPequena ? 45 : 98,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🌄 Fondo superior derecha decorativo
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Objetivos/Fondo_Supeior_Izquierda.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🌄 Fondo inferior izquierda
          Positioned(
            bottom: 90,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Objetivos/Fondo_inferior_Izquierda.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🌄 Fondo inferior derecha
          Positioned(
            bottom: 90,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Objetivos/Fondo_Inferior_Derecha.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
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
                'assets/Icono_Bombilla.png',
                width: esPantallaPequena ? 45 : 98,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 📜 Contenido principal
          SafeArea(
            child: Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  // Scroll del contenido
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child:
                          esPantallaPequena
                              ? InteractiveViewer(
                                // 🔍 Zoom solo en pantallas pequeñas
                                constrained: true,
                                minScale: 1.0,
                                maxScale: 5.0,
                                child: Column(
                                  children: [
                                    Text(
                                      '¿Sabes como crear los Objetivos?',
                                      style: TextStyle(
                                        fontSize: tamanotexto(1) + 5,
                                        fontFamily: 'Calibri',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildercard(),
                                    SizedBox(height: altura(1)),
                                  ],
                                ),
                              )
                              : Column(
                                // 💻 En pantallas grandes sin zoom
                                children: [
                                  Text(
                                    '¿Sabes como crear los Objetivos?',
                                    style: TextStyle(
                                      fontSize: tamanotexto(1) + 5,
                                      fontFamily: 'Calibri',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 35),
                                  _buildercard(),
                                  SizedBox(height: altura(1)),
                                ],
                              ),
                    ),
                  ),

                  // 🔘 Navegación inferior
                  _buildNavigation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildercard() {
    return LayoutBuilder(
      // se usa LayoutBuilder para obtener el tamaño de la pantalla
      builder: (context, Constraints) {
        bool esPantallaPequena = Constraints.maxWidth < 1000;
        // se usa bool para saber si la pantalla es pequena

        final alturaImagenPequena = Pequena(context);
        final alturaImagengrande = grande(context);
        return Card(
          color: obtenercolor('Color_Fondo'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            // se usa shape para darle un borde redondeado al card
          ),
          elevation: 4, // se usa elvation para darle una sombra al card
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                // se usa CrossAxisAlignment.start para alinear el texto a la izquierda
                children: [
                  Text(
                    secciones[_index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                      fontSize: tamanotexto(1) - 10,
                      color: obtenercolor('Color_Principal'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  esPantallaPequena
                      ? Column(
                        // se usa Column para mostrar el texto en dos filas
                        children: [
                          if (_index == 1)
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'Calibri',
                                  height: 1.5,
                                  //color: Colors.black,
                                ),
                                children: [
                                  TextSpan(text: 'El modelo '),
                                  TextSpan(
                                    text: 'SMART',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: ' –acrónimo que significa '),
                                  TextSpan(
                                    text: '«inteligente» ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'en inglés– hace referencia a cinco conceptos que hay'
                                        'que tener presentes constantemente a la hora de fijar objetivos si lo que buscamos es validar su pertinencia.',
                                  ),
                                  TextSpan(
                                    text: ' Por orden, los conceptos son ',
                                  ),
                                  TextSpan(
                                    text:
                                        '«específico» (S, specific), «medible» (M, measurable), «asignable» (A, assignable),'
                                        ' «realista» (R, realistic), «temporal» (T, time-related), ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'es decir, determinado en el tiempo. Según Steffens, G.,'
                                        ' & Cadiat, A. C. (2016). Los criterios SMART: El método para fijar objetivos con éxito. 50Minutos.',
                                  ),
                                ],
                              ),
                            ),
                          if (_index == 2)
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'Calibri',
                                  height: 1.5,
                                  //color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Esta metodología se basa en que el logro de un objetivo debe suponer un esfuerzo para que este sea relevante. Además,'
                                        ' incorpora nuevos elementos poco frecuentes hasta el momento en el planteamiento de objetivos tales como la legalidad o'
                                        ' el impacto en el medio ambiente. Según: ',
                                  ),
                                  TextSpan(
                                    text:
                                        'https://www.itik.cat/uploads/files/5%20m%C3%A9todos %20para%20establecer%20objetivos.pdf',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            abrirLink(
                                              'https://www.itik.cat/uploads/files/5%20m%C3%A9todos%20para%20establecer%20objetivos.pdf',
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          if (_index == 3)
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'Calibri',
                                  height: 1.5,
                                  //color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'La responsabilidad social y ética en las organizaciones cada vez está más presente en las estrategias de futuro,'
                                        ' y la metodología',
                                  ),
                                  TextSpan(
                                    text: ' PURE ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'se focaliza en la ética y relevancia de la concreción de los objetivos. Los elementos clave son: ',
                                  ),
                                  TextSpan(
                                    text:
                                        '• Positive stated (enunciados en positivo) • Understood (comprensible) • Relevant (relevante) • Ethical (ético).',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_index == 4)
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'Calibri',
                                  height: 1.5,
                                  //color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Esta metodología propone una revisión del contexto en el que se definen los objetivos de una organización o de un proyecto'
                                        ' específico. Establece que el deseo y el compromiso son elementos indispensables para el logro de las metas propuestas asociando'
                                        ' también este camino a un crecimiento personal y profesional. ',
                                  ),
                                  TextSpan(
                                    text:
                                        '• Goal (meta) • Reality (realidad)• Options (opciones)• Will (deseo).',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_index != 1 &&
                              _index != 2 &&
                              _index != 3 &&
                              _index != 4)
                            Text(
                              textos[_index],
                              style: TextStyle(
                                fontSize: tamanotexto(2) + 4,
                                fontFamily: 'Calibri',
                                height: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          if (_index == 6)
                            Center(
                              child: RichText(
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
                                      text:
                                          'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                                    ),
                                    TextSpan(
                                      text: 'Video explicativo.',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        //decoration: TextDecoration.underline,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              abrirLink(
                                                'https://youtu.be/WwmEpjQ4knE',
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          if (_index <= 6)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                imagenes[_index],
                                height: alturaImagenPequena[_index],
                                fit: BoxFit.contain,
                              ),
                            ),
                        ],
                      )
                      : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  if (_index == 1)
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: tamanotexto(2) + 4,
                                          fontFamily: 'Calibri',
                                          height: 1.5,
                                          //color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(text: 'El modelo '),
                                          TextSpan(
                                            text: 'SMART',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' –acrónimo que significa ',
                                          ),
                                          TextSpan(
                                            text: '«inteligente» ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'en inglés– hace referencia a cinco conceptos que hay'
                                                'que tener presentes constantemente a la hora de fijar objetivos si lo que buscamos es validar su pertinencia.',
                                          ),
                                          TextSpan(
                                            text:
                                                ' Por orden, los conceptos son ',
                                          ),
                                          TextSpan(
                                            text:
                                                '«específico» (S, specific), «medible» (M, measurable), «asignable» (A, assignable),'
                                                ' «realista» (R, realistic), «temporal» (T, time-related), ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'es decir, determinado en el tiempo. Según Steffens, G.,'
                                                ' & Cadiat, A. C. (2016). Los criterios SMART: El método para fijar objetivos con éxito. 50Minutos.',
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_index == 2)
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: tamanotexto(2) + 4,
                                          fontFamily: 'Calibri',
                                          height: 1.5,
                                          //color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Esta metodología se basa en que el logro de un objetivo debe suponer un esfuerzo para que este sea relevante. Además,'
                                                ' incorpora nuevos elementos poco frecuentes hasta el momento en el planteamiento de objetivos tales como la legalidad o'
                                                ' el impacto en el medio ambiente. Según: ',
                                          ),
                                          TextSpan(
                                            text:
                                                'https://www.itik.cat/uploads/files/5%20m%C3%A9todos %20para%20establecer%20objetivos.pdf',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              //decoration: TextDecoration.underline,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () {
                                                    abrirLink(
                                                      'https://www.itik.cat/uploads/files/5%20m%C3%A9todos%20para%20establecer%20objetivos.pdf',
                                                    );
                                                  },
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_index == 3)
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: tamanotexto(2) + 4,
                                          fontFamily: 'Calibri',
                                          height: 1.5,
                                          //color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'La responsabilidad social y ética en las organizaciones cada vez está más presente en las estrategias de futuro,'
                                                ' y la metodología',
                                          ),
                                          TextSpan(
                                            text: ' PURE ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'se focaliza en la ética y relevancia de la concreción de los objetivos. Los elementos clave son: ',
                                          ),
                                          TextSpan(
                                            text:
                                                '• Positive stated (enunciados en positivo) • Understood (comprensible) • Relevant (relevante) • Ethical (ético).',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_index == 4)
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: tamanotexto(2) + 4,
                                          fontFamily: 'Calibri',
                                          height: 1.5,
                                          //color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Esta metodología propone una revisión del contexto en el que se definen los objetivos de una organización o de un proyecto'
                                                ' específico. Establece que el deseo y el compromiso son elementos indispensables para el logro de las metas propuestas asociando'
                                                ' también este camino a un crecimiento personal y profesional. ',
                                          ),
                                          TextSpan(
                                            text:
                                                '• Goal (meta) • Reality (realidad)• Options (opciones)• Will (deseo).',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  if (_index != 1 &&
                                      _index != 2 &&
                                      _index != 3 &&
                                      _index != 4)
                                    Text(
                                      textos[_index],
                                      style: TextStyle(
                                        fontSize: tamanotexto(2) + 4,
                                        fontFamily: 'calibri',
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  if (_index == 6)
                                    Center(
                                      child: RichText(
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: tamanotexto(2) + 6,
                                            fontFamily: 'Calibri',
                                            height: 1.5,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Para comprender mejor este tema, te invitamos a ingresar al siguiente enlace y ver el ',
                                            ),
                                            TextSpan(
                                              text: 'Video explicativo.',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                //decoration: TextDecoration.underline,
                                              ),
                                              recognizer:
                                                  TapGestureRecognizer()
                                                    ..onTap = () {
                                                      abrirLink(
                                                        'https://youtu.be/WwmEpjQ4knE',
                                                      );
                                                    },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          if (_index <= 6)
                            Flexible(
                              flex: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    imagenes[_index],
                                    height: alturaImagengrande[_index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                  if (_index == 1)
                    Center(
                      child: Image.asset(
                        height:
                            esPantallaPequena
                                ? MediaQuery.of(context).size.width * 0.3 - 18
                                : MediaQuery.of(context).size.width * 0.2 - 18,
                        'assets/Objetivos/Objetivos_Método_Smart_Titulo.png',
                      ),
                    ),
                  if (_index == 2)
                    Center(
                      child: Image.asset(
                        height:
                            esPantallaPequena
                                ? MediaQuery.of(context).size.width * 0.45 - 18
                                : MediaQuery.of(context).size.width * 0.35 - 18,
                        'assets/Objetivos/Objetivos_Método_Clear_Titulo.png',
                      ),
                    ),
                  if (_index == 5)
                    Center(
                      child: Image.asset(
                        height:
                            esPantallaPequena
                                ? MediaQuery.of(context).size.width * 0.35 - 18
                                : MediaQuery.of(context).size.width * 0.3 - 18,
                        'assets/Objetivos/Objetivos_Método_Dumb_Titulo.png',
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigation() {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_index > 0) {
                  final anterior = _index - 1;
                  _tabController.animateTo(anterior);
                  setState(() {
                    _index = anterior;
                    if (!pestanasVistas.contains(anterior)) {
                      pestanasVistas.add(anterior);
                      ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + anterior);
                    }
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Justificacion(),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.arrow_back,
                size: tamanotexto(2),
                color: obtenercolor('Color_Texto'),
              ),
              label: Text(
                'Anterior',
                style: TextStyle(
                  color: obtenercolor('Color_Texto'),
                  fontFamily: 'Calibri',
                  fontSize: tamanotexto(2),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: obtenercolor('Color_Principal'),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_index < secciones.length - 1) {
                  _tabController.animateTo(_index + 1);
                  setState(() async {
                    _currentseccion = _index + 1;
                    if (!pestanasVistas.contains(_index + 1)) {
                      pestanasVistas.add(_index + 1);
                      ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + _index + 1);
                      await guardarProgresoFinal(ID_BASE_PROGRESO);
                    }
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Metodologia(),
                    ),
                  );
                  await guardarProgresoFinal(2);
                }
              },
              icon: Icon(
                Icons.arrow_forward,
                size: tamanotexto(2),
                color: obtenercolor('Color_Texto'),
              ),
              label: Text(
                _index < secciones.length - 1 ? 'Siguiente' : 'Adelante',
                //si el index es menor que la longitud de la lista de secciones, se muestra 'Siguiente', de lo contrario se muestra 'Adelante'
                style: TextStyle(
                  color: obtenercolor('Color_Texto'),
                  fontFamily: 'Calibri',
                  fontSize: tamanotexto(2),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: obtenercolor('Color_Principal'),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void modalmenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height *
            0.3, // altura máxima de la hoja modal
        minHeight: 0, // altura mínima de la hoja modal
        maxWidth:
            MediaQuery.of(context).size.width, // ancho máximo de la hoja modal
        minWidth: 0, // ancho mínimo de la hoja modal
      ),
      backgroundColor: Colors.transparent,
      builder: (x) {
        return Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Container(
            decoration: BoxDecoration(
              color: obtenercolor('Color_Fondo'),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: _buildGridMenu(context),
          ),
        );
      },
    );
  }

  Widget _buildGridMenu(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool esPantallaGrande = kIsWeb || screenWidth > 600;

    final ScrollController scrollController = ScrollController();
    final double itemWidth = esPantallaGrande ? 180 : 120;
    final double itemSpacing = 24; // margen horizontal * 2 (12+12)
    final double totalContentWidth =
        (itemWidth + itemSpacing) * menuItems.length;

    double sidePadding = 0;
    if (totalContentWidth < screenWidth) {
      sidePadding = (screenWidth - totalContentWidth) / 2;
    }

    return SizedBox(
      height: 190,
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        interactive: true,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: menuItems.length,
          padding: EdgeInsets.symmetric(horizontal: sidePadding),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            final bool isVisited = pestanasVistas.contains(item['indice']);
            final bool isSelected = _tabController.index == item['indice'];

            return SizedBox(
              width: itemWidth,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    final nuevoIndex = item['indice'];
                    if (nuevoIndex != null) {
                      _tabController.animateTo(nuevoIndex);
                      setState(() {
                        _index = nuevoIndex;
                        if (!pestanasVistas.contains(nuevoIndex)) {
                          pestanasVistas.add(nuevoIndex);
                          ProgresoGlobal.marcarVisto(item['id']);
                          //_progresoContador++;
                        }
                      });
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              (isSelected || isVisited)
                                  ? obtenercolor(
                                    'Color_Principal',
                                  ).withOpacity(0.2)
                                  : item['color'].withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          item['icon'],
                          size: tamanotexto(3),
                          color:
                              (isSelected || isVisited)
                                  ? obtenercolor('Color_Principal')
                                  : item['color'],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['text'],
                        style: TextStyle(fontSize: tamanotexto(2)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> menuItems = [
    {
      'id': 2,
      'text': 'Cración de objetivos',
      'icon': Icons.flag_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Metodo SMART',
      'icon': Icons.visibility,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Metodo CLEAR',
      'icon': Icons.group_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 6,
      'text': 'Metodo PURE',
      'icon': Icons.thumb_up_alt_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
    {
      'id': 7,
      'text': 'Metodo GROW',
      'icon': Icons.list_alt_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 4,
    },
    {
      'id': 8,
      'text': 'Metodo DUMB',
      'icon': Icons.emoji_events_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 5,
    },
    {
      'id': 9,
      'text': 'Arbol de objetivos',
      'icon': Icons.call_split,
      'color': obtenercolor('Color_Secundario'),
      'indice': 6,
    },
  ];
}
