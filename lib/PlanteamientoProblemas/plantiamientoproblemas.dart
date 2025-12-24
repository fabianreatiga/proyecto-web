// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Justificacion/justificacion.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/Titulo/titulo.dart';
import 'package:nuevomockups/global.dart';

class Plantiamientoproblemas extends StatelessWidget {
  const Plantiamientoproblemas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: const PlatieamientoProblemas(),
    );
  }
}

class PlatieamientoProblemas extends StatefulWidget {
  const PlatieamientoProblemas({super.key});

  @override
  State<PlatieamientoProblemas> createState() => _PlatieamientoProblemasState();
}

class _PlatieamientoProblemasState extends State<PlatieamientoProblemas>
    with TickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;
  final List<int> pestanasVistas = [];
  // esta lista guarda las pestañas que ya se han visto

  // Defino una constante base para IDs de progreso para evitar confusiones

  final List<String> textos = [
    'El planteamiento del problema es el punto de partida de todo proyecto o investigación. '
        'El problema expresa un vacío en el conocimiento o una necesidad que debe ser resuelta. '
        'La problemática requiere un sustento que haga evidente la necesidad de resolver el problema a tratar.',

    'Tener en cuenta:\n • ¿Qué es lo que se pretende conocer de un determinado objeto de estudio a partir de su '
        'investigación?\n • ¿De qué manera se piensa abordar la temática para esclarecer su desconocimiento?',

    'Se recomiendan estas 4 metodologías:\n • 5W1H,\n• Espina de pescado,\n• Árbol de problemas,\n• Esquema de redacción.',

    /*'Ejemplos: Qué (WHAT): Hay personas que sufren de los ojos, conjuntivitis alergénica y llevan aplicándose '
        'medicamento hace mucho tiempo sin curarse. Porqué (WHY): Porque los medicamentos que se aplican no son '
        'efectivos. Cuando (WHEN): Virosis de conjuntivitis, cuando hay altas tasas de polución y cuando se usa '
        'mucho los celulares o pantallas. Dónde (WHERE): Ciudades con mayor polución, en el campo durante las quemas '
        'y preparación, cuando cocina con leña, en personal de obra constructivo. En niños de etapa temprana. '
        'Quién (WHO): Personal de construcción, agricultores, niños, madres cabeza de familia que cocinan con '
        'leña, adultos mayores, personas que trabajan muchas horas desde la pantalla. Cómo (HOW): Medicamentos '
        'formulados, miel, otros remedios para los ojos. Cirugía.',*/
    '',

    'Basado en el análisis de los ítems anteriores se redacta un párrafo general con la descripción de '
        'la problemática identificada.',

    '',
    //'Esquemas que pueden ayudar a plantear la problemática. 1. Para productos: Hemos observado que el '
    //  '[Producto o servicio] no está cumpliendo [con estos objetivos], lo cual está causando [efecto negativo] '
    //  'a nuestro [impacto en el negocio].',

    /*
    'Esquemas que pueden ayudar a plantear la problemática. 1. Cuándo es un punto de vista: [Tipo de usuario] '
        'intenta [descripción de su necesidad u objetivo] pero [barrera] porque [hallazgo] lo cual le hace sentir '
        '[efecto negativo].',*/
    '',

    'Herramienta para el análisis de los problemas que básicamente representa la relación entre un efecto (problema) '
        'y todas las posibles causas que lo ocasionan. Diagrama de causa-efecto.',
    '¿Cómo hacer el diagrama de Ishikawa?',

    'Ejemplo utilizando las categorías tradicionales.',

    'Ejemplo creando las categorías según la necesidad del proyecto.',

    'Es una herramienta gráfica que permite visualizar de forma sistemática un problema central con sus '
        'causas y consecuencias como raíces y ramas respectivamente. El tronco constituye el problema central. '
        'Las raíces son las causas. Las ramas son las consecuencias.',

    '',

    'Ejemplo árbol de problemas:',

    'Estructura del Planteamiento del problema:\n',
  ];

  final List<String> imagenes = [
    'assets/PlanteamientoProblema/Planteamiento_del_Problema.png', // PLANTEAMIENTO DEL PROBLEMA
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Definicion.png', // DEFINICIÓN
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Metodologia.png', // METODOLOGIAS
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_5W1H.png', // 5W1H
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Ejemplo_5W1H.png', // EJEMPLO 5W1H
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Ejemplo_2_5W1H.png', // EJEMPLO 2 5W1H
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Ejemplo_3_5W1H.png', // EJEMPLO 3 5W1H
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Espina_De_Pescado.jpeg', // ESPINA DE PESCADO
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Como_Hacer_Una_Espina_De_Pescado.png', // COMO HACER ESPINA DE PESCADO
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Ejemplo_1_Espina_De_Pescado.png', // EJEMPLO 1 ESPINA DE PESCADO
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Ejemplo_2_Espina_De_Pescado.png', // EJEMPLO 2 ESPINA DE PESCADO
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Arbol_De_Problemas.png', // ÁRBOL DE PROBLEMAS
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Como_Hacer_Arbol_De_Problemas.png', // COMO HACER EL ÁRBOL DE PROBLEMAS
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Ejemplo_Arbol_De_Problemas.png', // EJEMPLO ÁRBOL DE PROBLEMAS
    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Esquema_de_Redaccion_Parte_1.png', // ESQUEMA DE REDACCIÓN
  ];

  final List<String> secciones = [
    'PLANTEAMIENTO DEL PROBLEMA',
    'DEFINICIÓN',
    'METODOLOGIAS',
    '5W1H',
    'EJEMPLO 5W1H',
    'EJEMPLO 2 5W1H',
    'EJEMPLO 3 5W1H',
    'ESPINA DE PESCADO',
    'COMO HACER ESPINA DE PESCADO',
    'EJEMPLO 1 ESPINA DE PESCADO',
    'EJEMPLO 2 ESPINA DE PESCADO',
    'ÁRBOL DE PROBLEMAS',
    'COMO HACER EL ÁRBOL DE PROBLEMAS',
    'EJEMPLO ÁRBOL DE PROBLEMAS',
    'ESQUEMA DE REDACCIÓN',
  ];

  List<double> ngrande(BuildContext context) {
    return [
      301, // PLANTEAMIENTO DEL PROBLEMA
      325, // DEFINICIÓN
      MediaQuery.of(context).size.width * 0.4, // METODOLOGIAS
      MediaQuery.of(context).size.width * 0.3 - 18, // 5W1H
      MediaQuery.of(context).size.width * 0.3, // EJEMPLO 5W1H
      MediaQuery.of(context).size.width * 0.3, // EJEMPLO 2 5W1H
      MediaQuery.of(context).size.width * 0.3, // EJEMPLO 3 5W1H
      MediaQuery.of(context).size.width * 0.35 - 18, // ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.35 -
          18, // COMO HACER ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.35 -
          18, // EJEMPLO 1 ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.33 -
          18, // EJEMPLO 2 ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.38 - 18, // ÁRBOL DE PROBLEMAS
      MediaQuery.of(context).size.width * 0.4 -
          18, // COMO HACER EL ÁRBOL DE PROBLEMAS
      MediaQuery.of(context).size.width * 0.45 -
          18, // EJEMPLO ÁRBOL DE PROBLEMAS
      MediaQuery.of(context).size.width * 0.3 - 18, // ESQUEMA DE REDACCIÓN
    ];
  }

  List<double> Pequena(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.4 -
          18, // PLANTEAMIENTO DEL PROBLEMA
      MediaQuery.of(context).size.width * 0.4 - 18, // DEFINICIÓN
      MediaQuery.of(context).size.width * 0.65 - 18, // METODOLOGIAS
      MediaQuery.of(context).size.width * 0.4 - 18, // 5W1H
      MediaQuery.of(context).size.width * 0.45 - 18, // EJEMPLO 5W1H
      MediaQuery.of(context).size.width * 0.45 - 18, // EJEMPLO 2 5W1H
      MediaQuery.of(context).size.width * 0.45 - 18, // EJEMPLO 3 5W1H
      MediaQuery.of(context).size.width * 0.45 - 18, // ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.45 -
          18, // COMO HACER ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.53 -
          18, // EJEMPLO 1 ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.5 -
          18, // EJEMPLO 2 ESPINA DE PESCADO
      MediaQuery.of(context).size.width * 0.45 - 18, // ÁRBOL DE PROBLEMAS
      MediaQuery.of(context).size.width * 0.55 -
          18, // COMO HACER EL ÁRBOL DE PROBLEMAS
      MediaQuery.of(context).size.width * 0.7 -
          18, // EJEMPLO ÁRBOL DE PROBLEMAS
      MediaQuery.of(context).size.width * 0.65 - 18, // ESQUEMA DE REDACCIÓN
    ];
  }

  int _currentseccion = 0;

  static int ID_BASE_PROGRESO = 7;

  @override
  void initState() {
    super.initState();
    // Se ejecuta una sola vez cuando se abre la pantalla.

    pestanasVistas.add(0);
    // Se marca la primera sección como vista porque es la que se muestra al iniciar.

    ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + 0);
    // Se registra la primera sección en el progreso general del aplicativo.

    _tabController = TabController(length: secciones.length, vsync: this);
    // Controla el cambio entre las diferentes secciones.

    _tabController.addListener(() {
      // Detecta cuando el usuario cambia de sección.

      if (!_tabController.indexIsChanging) {
        // Se ejecuta solo cuando el cambio de sección termina.

        setState(() => _index = _tabController.index);
        // Actualiza la sección actual que se muestra en pantalla.

        if (!pestanasVistas.contains(_tabController.index)) {
          // Verifica si la sección aún no ha sido visitada.

          pestanasVistas.add(_tabController.index);
          // Guarda la sección como vista.

          ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + _tabController.index);
          // Actualiza el progreso del usuario.
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Se verifica si la pantalla es pequeña (celular o tablet)
    final bool esPantallaPequena =
        MediaQuery.of(context).size.shortestSide < 650;

    return Scaffold(
      // Color de fondo general de la pantalla
      backgroundColor: obtenercolor('Color_Fondo'),

      // Barra superior personalizada con progreso y menú
      appBar: Appbar2(
        nombre: '',
        progreso: ProgresoGlobal.progreso,
        actions: [
          // Botón para abrir el menú inferior de secciones
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

      // Menú lateral (Drawer) con control de progreso
      drawer: Menu(
        currentScreen: 'PlantiamientoProblema',
        progreso: ProgresoGlobal.porcentaje,
      ),

      body: Stack(
        children: [
          // Imagen decorativa superior derecha
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/PlanteamientoProblema/Fondo_superior_Derecha.png',
                width: esPantallaPequena ? 120 : 250,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Imagen decorativa superior izquierda
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/PlanteamientoProblema/Fondo_Supeior_Izquierda.png',
                width: esPantallaPequena ? 120 : 250,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Imagen decorativa inferior izquierda
          Positioned(
            bottom: 90,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/PlanteamientoProblema/Fondo_inferior_Izquierda.png',
                width: esPantallaPequena ? 120 : 250,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Imagen decorativa inferior derecha
          Positioned(
            bottom: 90,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/PlanteamientoProblema/Fondo_Inferior_Derecha.png',
                width: esPantallaPequena ? 120 : 250,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Contenido principal de la pantalla
          SafeArea(
            child: Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  // Área desplazable del contenido
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: esPantallaPequena
                          ? InteractiveViewer(
                              // Permite hacer zoom solo en pantallas pequeñas
                              constrained: true,
                              minScale: 1.0,
                              maxScale: 5.0,
                              child: Column(
                                children: [
                                  // Título principal del módulo
                                  Text(
                                    '¿Sabes cómo crear un Planteamiento del Problema?',
                                    style: TextStyle(
                                      fontSize: tamanotexto(1) + 5,
                                      fontFamily: 'Calibri',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  // Tarjeta con el contenido de la sección actual
                                  _buildTimelineCard(),
                                  SizedBox(height: altura(1)),
                                ],
                              ),
                            )
                          : Column(
                              // En pantallas grandes no se usa zoom
                              children: [
                                Text(
                                  '¿Sabes cómo crear un Planteamiento del Problema?',
                                  style: TextStyle(
                                    fontSize: tamanotexto(1) + 5,
                                    fontFamily: 'Calibri',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                _buildTimelineCard(),
                                SizedBox(height: altura(1)),
                              ],
                            ),
                    ),
                  ),

                  // Barra de navegación inferior (Anterior / Siguiente)
                  _buildNavigation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Detecta si la pantalla es pequeña o grande
        bool esPantallaPequena = constraints.maxWidth < 1000;

        // Alturas de imágenes según el tamaño de pantalla
        final alturaImagenPequena = Pequena(context);
        final alturaImagengrande = ngrande(context);

        return Card(
          // Tarjeta principal del contenido
          color: obtenercolor('Color_Fondo'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,

          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              // Fondo decorativo interno
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
                  // Título de la sección actual
                  Text(
                    secciones[_index],
                    style: TextStyle(
                      fontSize: tamanotexto(1) - 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                      color: obtenercolor('Color_Principal'),
                      backgroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== VISTA PARA PANTALLAS PEQUEÑAS =====
                  esPantallaPequena
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Ejemplo 5W1H
                              if (_index == 3)
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: tamanotexto(2) + 4,
                                      fontFamily: 'Calibri',
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(text: 'Ejemplos: '),
                                      TextSpan(
                                        text: 'Qué (WHAT): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            ' Hay personas que sufren de los ojos, conjuntivitis alergénica y llevan aplicándose medicamento hace mucho tiempo sin curarse. ',
                                      ),
                                      TextSpan(
                                        text: 'Porqué (WHY): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'Virosis de conjuntivitis, cuando hay altas tasas de polución y cuando se usa mucho los celulares o pantallas. ',
                                      ),
                                      TextSpan(
                                        text: 'Cuando (WHEN): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'Virosis de conjuntivitis, cuando hay altas tasas de polución y cuando se usa mucho los celulares o pantallas. ',
                                      ),
                                      TextSpan(
                                        text: 'Dónde (WHERE): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'Ciudades con mayor polución, en el campo durante las quemas y preparación, cuando cocina con leña, en personal de obra constructivo. En niños de etapa temprana. ',
                                      ),
                                      TextSpan(
                                        text: 'Quién (WHO): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'Personal de construcción, agricultores, niños, madres cabeza de familia que cocinan con leña, adultos mayores, personas que trabajan muchas horas desde la pantalla. ',
                                      ),
                                      TextSpan(
                                        text: 'Cómo (HOW): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                              // Esquema de redacción (producto)
                              if (_index == 5)
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: tamanotexto(2) + 4,
                                      fontFamily: 'Calibri',
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Esquemas que pueden ayudar a plantear la problemática. 1. Para productos: Hemos observado que el ',
                                      ),
                                      TextSpan(
                                        text: '[Producto o servicio] ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: ' no está cumpliendo '),
                                      TextSpan(
                                        text: '[con estos objetivos],',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: ' lo cual está causando '),
                                      TextSpan(
                                        text: '[efecto negativo] ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: ' a nuestro '),
                                      TextSpan(
                                        text: '[impacto en el negocio].',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                              // Esquema de redacción (usuario)
                              if (_index == 6)
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: tamanotexto(2) + 4,
                                      fontFamily: 'Calibri',
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Esquemas que pueden ayudar a plantear la problemática. 1. Cuándo es un punto de vista: ',
                                      ),
                                      TextSpan(
                                        text: '[Tipo de usuario] ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: 'intenta '),
                                      TextSpan(
                                        text:
                                            '[descripción de su necesidad u objetivo] ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: 'pero '),
                                      TextSpan(
                                        text: '[barrera] ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: 'porque '),
                                      TextSpan(
                                        text: '[hallazgo] ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: 'lo cual le hace sentir '),
                                      TextSpan(
                                        text: '[efecto negativo].',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                              // Texto general de la sección
                              Text(
                                textos[_index],
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'Calibri',
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),

                              const SizedBox(height: 20),

                              // Imagen principal
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  imagenes[_index],
                                  height: alturaImagenPequena[_index],
                                  fit: BoxFit.contain,
                                ),
                              ),

                              // Imagen adicional para esquema de redacción
                              if (_index == 14)
                                SizedBox(
                                  height: 500,
                                  child: Image.asset(
                                    'assets/PlanteamientoProblema/Planteamiento_del_Problema_Esquema_de_Redaccion_Parte_2.png',
                                  ),
                                ),
                            ],
                          ),
                        )

                      // ===== VISTA PARA PANTALLAS GRANDES =====
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Columna izquierda (texto)
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Se reutilizan los mismos textos especiales
                                    // según el índice (_index == 3, 5, 6)
                                    // y el texto general
                                    Text(
                                      textos[_index],
                                      style: TextStyle(
                                        fontSize: tamanotexto(2) + 4,
                                        fontFamily: 'Calibri',
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Columna derecha (imagen)
                            Flexible(
                              flex: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        imagenes[_index],
                                        height: alturaImagengrande[_index],
                                        fit: BoxFit.contain,
                                      ),
                                      if (_index == 13) SizedBox(width: 100),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Ajustes visuales según sección
                            if (_index == 2 || _index == 8 || _index == 12)
                              Spacer(),
                            if (_index == 9 || _index == 10)
                              SizedBox(width: 100),
                            if (_index == 12) Spacer(),

                            // Imagen extra para esquema de redacción
                            if (_index == 14)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.28 -
                                        18,
                                child: Image.asset(
                                  'assets/PlanteamientoProblema/Planteamiento_del_Problema_Esquema_de_Redaccion_Parte_2.png',
                                ),
                              ),
                          ],
                        ),

                  // ===== ENLACE SOLO EN LA ÚLTIMA SECCIÓN =====
                  if (_index == 14) SizedBox(height: 20),
                  if (_index == 14)
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
                              text: 'Video explicativo',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  abrirLink('https://youtu.be/dKs0BfuF25A');
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
        );
      },
    );
  }

  Widget _buildNavigation() {
    return Container(
      // Contenedor de la barra de navegación inferior
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.transparent,

      child: Row(
        // Distribuye los botones a los extremos
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ===== BOTÓN ANTERIOR =====
          SizedBox(
            width: 150,
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () {
                // Si no estoy en la primera sección
                if (_index > 0) {
                  final anterior = _index - 1;

                  // Mueve el controlador a la sección anterior
                  _tabController.animateTo(anterior);

                  setState(() {
                    // Actualiza el índice actual
                    _index = anterior;

                    // Registra la sección como vista si no lo estaba
                    if (!pestanasVistas.contains(anterior)) {
                      pestanasVistas.add(anterior);
                      ProgresoGlobal.marcarVisto(
                        ID_BASE_PROGRESO + anterior,
                      );
                    }
                  });
                } else {
                  // Si está en la primera sección, regresa a la pantalla de Título
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Titulo()),
                  );
                }
              },

              // Ícono del botón anterior
              icon: Icon(
                Icons.arrow_back,
                size: tamanotexto(2),
                color: obtenercolor('Color_Texto'),
              ),

              // Texto del botón anterior
              label: Text(
                'Anterior',
                style: TextStyle(
                  color: obtenercolor('Color_Texto'),
                  fontSize: tamanotexto(2),
                  fontFamily: 'Calibri',
                ),
              ),

              // Estilo del botón
              style: ElevatedButton.styleFrom(
                backgroundColor: obtenercolor('Color_Principal'),
                padding: EdgeInsets.zero,
              ),
            ),
          ),

          // ===== BOTÓN SIGUIENTE =====
          SizedBox(
            width: 150,
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () async {
                // Si aún hay más secciones por recorrer
                if (_index < secciones.length - 1) {
                  // Avanza a la siguiente sección
                  _tabController.animateTo(_index + 1);

                  // Actualiza la sección actual en la interfaz
                  setState(() {
                    _currentseccion = _index + 1;
                  });

                  // Calcula el ID real del progreso
                  int idReal = ID_BASE_PROGRESO + _index + 1;

                  // Guarda el progreso solo si no se ha registrado antes
                  if (!ProgresoGlobal.pestanasVistas.contains(idReal)) {
                    ProgresoGlobal.pestanasVistas.add(idReal);

                    // Guarda el progreso de forma local
                    await ProgresoGlobal.guardarLocal();

                    // Mensaje de control en consola
                    print(" Progreso sumado → ID: $idReal");

                    // Guarda el progreso en la base de datos (MongoDB)
                    await guardarProgresoEnAPI(idReal);
                  }
                } else {
                  // Si es la última sección, avanza a Justificación
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Justificacion(),
                    ),
                  );

                  // Marca el progreso final correspondiente
                  ProgresoGlobal.marcarVisto(2);
                }
              },

              // Texto del botón (cambia en la última sección)
              label: Text(
                _index < secciones.length - 1 ? 'Siguiente' : 'Adelante',
                style: TextStyle(
                  color: obtenercolor('Color_Texto_Principal'),
                  fontSize: tamanotexto(2),
                ),
              ),

              // Ícono del botón siguiente
              icon: Icon(
                Icons.arrow_forward,
                size: tamanotexto(2),
                color: obtenercolor('Color_Texto_Principal'),
              ),

              // Estilo del botón
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
    // Muestra un menú modal desde la parte inferior de la pantalla
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      // Se definen los límites de tamaño del modal
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        // Altura máxima del menú modal

        minHeight: 0,
        // Altura mínima del menú modal

        maxWidth: MediaQuery.of(context).size.width,
        // Ancho máximo del menú modal

        minWidth: 0,
        // Ancho mínimo del menú modal
      ),

      backgroundColor: Colors.transparent,
      // Se deja transparente para respetar el diseño personalizado

      builder: (x) {
        return Align(
          // Alinea el menú en la parte inferior de la pantalla
          alignment: AlignmentDirectional.bottomStart,
          child: Container(
            // Contenedor principal del menú
            decoration: BoxDecoration(
              color: obtenercolor('Color_Fondo'),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),

            // Contenido del menú (grilla horizontal)
            child: _buildGridMenu(context),
          ),
        );
      },
    );
  }

  Widget _buildGridMenu(BuildContext context) {
    // Obtiene el ancho de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;

    // Determina si es web o una pantalla grande
    final bool esPantallaGrande = kIsWeb || screenWidth > 600;

    // Controlador del scroll horizontal
    final ScrollController scrollController = ScrollController();

    // Ancho de cada ítem del menú según el tamaño de pantalla
    final double itemWidth = esPantallaGrande ? 180 : 120;

    // Espaciado horizontal total por ítem
    final double itemSpacing = 24;

    // Ancho total del contenido del menú
    final double totalContentWidth =
        (itemWidth + itemSpacing) * menuItems.length;

    double sidePadding = 0;

    // Centra los ítems si hay espacio sobrante
    if (totalContentWidth < screenWidth) {
      sidePadding = (screenWidth - totalContentWidth) / 2;
    }

    return SizedBox(
      // Altura fija del menú
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
            // Obtiene el ítem actual del menú
            final item = menuItems[index];

            // Verifica si el ítem ya fue visitado
            final bool isVisited = pestanasVistas.contains(item['indice']);

            // Verifica si el ítem es el actual
            final bool isSelected = _tabController.index == item['indice'];

            return SizedBox(
              width: itemWidth,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () async {
                    // Guarda el progreso al seleccionar una sección
                    await guardarProgresoEnAPI(item['id']);

                    // Cierra el menú modal
                    Navigator.pop(context);

                    final nuevoIndex = item['indice'];

                    if (nuevoIndex != null) {
                      // Navega a la sección seleccionada
                      _tabController.animateTo(nuevoIndex);

                      setState(() {
                        _index = nuevoIndex;

                        // Marca la sección como vista si no lo estaba
                        if (!pestanasVistas.contains(nuevoIndex)) {
                          pestanasVistas.add(nuevoIndex);
                          ProgresoGlobal.marcarVisto(item['id']);
                        }
                      });
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ícono circular del menú
                      Container(
                        decoration: BoxDecoration(
                          color: (isSelected || isVisited)
                              ? obtenercolor('Color_Principal').withOpacity(0.2)
                              : item['color'].withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          item['icon'],
                          size: tamanotexto(3),
                          color: (isSelected || isVisited)
                              ? obtenercolor('Color_Principal')
                              : item['color'],
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Texto del ítem del menú
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
      'text': 'Planteamiento',
      'icon': Icons.lightbulb_outline,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Definición',
      'icon': Icons.description_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Metodologías',
      'icon': Icons.list_alt,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 5,
      'text': '5W1H',
      'icon': Icons.help_outline,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
    {
      'id': 6,
      'text': 'Ejemplo 5W1H',
      'icon': Icons.article_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 4,
    },
    {
      'id': 7,
      'text': 'Ejemplo 2 5W1H',
      'icon': Icons.fact_check,
      'color': obtenercolor('Color_Secundario'),
      'indice': 5,
    },
    {
      'id': 8,
      'text': 'ejemplo 3 5W1H',
      'icon': Icons.task_alt,
      'color': obtenercolor('Color_Secundario'),
      'indice': 6,
    },
    {
      'id': 9,
      'text': 'Espina de pescado',
      'icon': Icons.schema,
      'color': obtenercolor('Color_Secundario'),
      'indice': 7,
    },
    {
      'id': 10,
      'text': 'Como hacer espina de pescado',
      'icon': Icons.device_hub,
      'color': obtenercolor('Color_Secundario'),
      'indice': 8,
    },
    {
      'id': 11,
      'text': 'Ejemplo espina de pescado',
      'icon': Icons.analytics_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 9,
    },
    {
      'id': 12,
      'text': 'Ejeplo 2 espina de pescado',
      'icon': Icons.insights_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 10,
    },
    {
      'id': 13,
      'text': 'Arbol de problemas',
      'icon': Icons.account_tree_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 11,
    },
    {
      'id': 14,
      'text': 'Como hacer el árbol de problemas',
      'icon': Icons.schema_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 12,
    },
    {
      'id': 15,
      'text': 'Ejemplo árbol de problemas',
      'icon': Icons.report_problem_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 13,
    },
    {
      'id': 16,
      'text': 'Esquema de redacción',
      'icon': Icons.edit_note,
      'color': obtenercolor('Color_Secundario'),
      'indice': 14,
    },
  ];
}
