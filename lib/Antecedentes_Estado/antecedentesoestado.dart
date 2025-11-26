// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';

import 'package:nuevomockups/Color_texto/color_texto.dart';

import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/Metodologia/metodologia.dart';
import 'package:nuevomockups/Objetivos/objetivos.dart';
import 'package:nuevomockups/global.dart';

// ignore: camel_case_types
class Antecedente_EStado extends StatelessWidget {
  const Antecedente_EStado({super.key});

  @override
  Widget build(BuildContext context) {
    return Antecedentes_Estados();
  }
}

// ignore: camel_case_types
class Antecedentes_Estados extends StatefulWidget {
  const Antecedentes_Estados({super.key});

  @override
  State<Antecedentes_Estados> createState() => _Antecedentes_EstadosState();
}

// ignore: camel_case_types
class _Antecedentes_EstadosState extends State<Antecedentes_Estados>
    with TickerProviderStateMixin {
  // ID único del subtema

  int _index = 0; //indica que las secciones inicia en la primera
  late TabController
  _tabController; //se usa un TabController para controlar las pestañas
  final List<int> pestanasVistas =
      []; // en esta variable se guarda las pestañas ya vistas

  final List<String> textos = [
    'Los antecedentes son una parte del trabajo de investigación donde se recopila y describe la información previa existente sobre el tema que se está estudiando. Incluyen investigaciones, artículos, tesis, proyectos o informes anteriores que abordan el mismo problema o uno relacionado. '
        'Su finalidad es mostrar qué se ha investigado antes, cuáles han sido los principales resultados obtenidos y cómo esos estudios sirven como base o referencia para tu propia investigación. Gracias a los antecedentes se puede entender el contexto, evitar repetir trabajos ya realizados y justificar por qué tu estudio es importante o necesario.',

    '',

    'El estado del arte es una parte esencial de toda investigación científica, técnica o académica. Consiste en revisar,'
        ' analizar y describir los conocimientos, teorías, métodos, avances y resultados que otros investigadores han desarrollado'
        ' previamente sobre el mismo tema o uno relacionado. Su objetivo principal es mostrar cómo está el conocimiento actual'
        ' sobre un tema y cuál ha sido su evolución a lo largo del tiempo. Es decir, permite entender qué se sabe, cómo se ha estudiado '
        'y qué falta por investigar. El término “estado del arte” proviene del inglés state of the art, que significa literalmente'
        ' “nivel más avanzado del conocimiento en un campo determinado”. En investigación, se utiliza para referirse a la recopilación'
        ' y análisis de la información más actualizada y relevante disponible.',

    'Imagina que vas a investigar sobre el uso de software educativo en colegios.'
        'Antes de empezar, revisa qué se ha estudiado sobre el tema:\n'
        '• Busca información en fuentes confiables como Google Académico, Scielo, Redalyc o Dialnet, usando palabras clave como “software educativo” o “herramientas digitales para el aprendizaje”.\n'
        '• Analiza los estudios existentes: algunos evalúan programas como Kahoot o Duolingo, aplicando encuestas o comparando el rendimiento antes y después de su uso.\n'
        '• Registra los principales hallazgos: la mayoría concluye que el software educativo mejora la motivación y participación de los estudiantes, aunque depende de la capacitación docente.\n'
        '• Detecta vacíos en la investigación: por ejemplo, el poco estudio del uso de software en zonas rurales o con acceso limitado a internet.',
  ];
  final List<String> imagenes = [
    'assets/BasesDatos/Bases_De_Datos_Antecedentes.png', //¿QUÉ SON LOS ANTECEDENTES?
    'assets/BasesDatos/Bases_De_Datos_Antecedentes_Ejemplo.png', //EJEMPLO DE ANTECEDENTES
    'assets/BasesDatos/Bases_De_Datos_Estado_Del_Arte.png', //¿QUÉ ES EL ESTADO DEL ARTE?
    'assets/BasesDatos/Bases_De_Datos_Estado_Del_Arte_Ejemplo.png', //EJEMPLOS
  ]; // lista de las imagenes

  // ignore: unused_field
  int _currentseccion = 0;

  final List<String> secciones = [
    '¿QUÉ SON LOS ANTECEDENTES?',
    'EJEMPLO',
    '¿QUÉ ES EL ESTADO DEL ARTE?',
    'EJEMPLO',
  ]; // lista de las secciones

  final List<double> alturaImagengrande = [
    250,
    300,
    250, // ¿QUÉ ES EL ESTADO DEL ARTE?
    350, // EJEMPLOS
  ]; // lista de las alturas de las imagenes para pantallas grandes

  final List<double> alturaImagenPequena = [
    250,
    250,
    150, // ¿QUÉ ES EL ESTADO DEL ARTE?
    250, // EJEMPLOS
  ]; // lista de las alturas de las imagenes para pantallas pequenas

  // ignore: non_constant_identifier_names
  static int ID_BASE_PROGRESO = 56; // ID base para el progreso de este subtema

  @override
  void initState() {
    super.initState();

    pestanasVistas.add(0);
    // Marca la primera pestaña vista con el ID base definido:
    ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + 0);

    _tabController = TabController(length: secciones.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _index = _tabController.index;
          if (!pestanasVistas.contains(_index)) {
            pestanasVistas.add(_index);
            ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + _index);
          }
        });
      }
    });
  } // es este bloque de codigo se usa para inicializar el estado del widget

  @override
  Widget build(BuildContext context) {
    // 📌 Ahora el nombre refleja la condición real
    final bool esPantallaPequena = MediaQuery.of(context).size.width < 650;

    return Scaffold(
      backgroundColor: obtenercolor('Color_Fondo'),
      appBar: Appbar2(
        nombre: '', // aca se mostrara el nombre del aprendiz
        progreso:
            ProgresoGlobal.progreso, // aca se muestra el progreso del aprendiz
        actions: [
          TextButton.icon(
            onPressed: () {
              modalmenu(context);
              // aca llamamos a modal menu
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

      // En este bloque de codigo se usa para mostrar y navegar por el modal menu
      drawer: const Menu(currentScreen: 'Arte'),
      body: Stack(
        children: [
          // 🌄 Fondo superior izquierda decorativo
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/BasesDatos/Fondo_inferior_Derecha.png',
                width: esPantallaPequena ? 250 : 400,
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
          /* Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/BasesDatos/Fondo_superior_Izqiuerda.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),*/

          // 🌄 Fondo inferior izquierda
          Positioned(
            bottom: 90,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/BasesDatos/Fondo_superior_Izqiuerda.png',
                width: esPantallaPequena ? 250 : 400,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🌄 Fondo inferior derecha
          /*Positioned(
            bottom: 90,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/BasesDatos/Fondo_inferior_Derecha.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),*/
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
                                      '¿Qué son los antecedentes o el estado del arte?',
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
                              )
                              : Column(
                                // 💻 En pantallas grandes sin zoom
                                children: [
                                  Text(
                                    '¿Qué son los antecedentes o el estado del arte?',
                                    style: TextStyle(
                                      fontSize: tamanotexto(1) + 5,
                                      fontFamily: 'Calibri',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 35),
                                  _buildTimelineCard(),
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

  Widget _buildTimelineCard() {
    // Función para abrir links correctamente en web y móvil

    return LayoutBuilder(
      //se usa LayoutBuilder para adaptar el tamaño de la pantalla
      builder: (context, constraints) {
        bool esPantallaPequena = constraints.maxWidth < 1000;
        //se bool para saber si la pantalla es pequena
        return Card(
          color: obtenercolor('Color_Fondo'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            //se usa shape para redondear los bordes del card
          ),
          elevation: 4, // se usa elevation para darle sombra al card
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 30,
            ),
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
                  esPantallaPequena
                      ? Column(
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
                                  TextSpan(
                                    text: 'Antecedente 1: \n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'En 2020, María Pérez realizó un estudio sobre el uso del celular en estudiantes de secundaria. Su investigación mostró que los jóvenes pasan en promedio 4 horas al día usando redes sociales. '
                                        'Este estudio es importante porque ayuda a entender cómo el uso del celular afecta el tiempo de estudio de los estudiantes.\n',
                                  ),

                                  TextSpan(
                                    text:
                                        'Este es un ejemplo básico que muestra:\n• Quién hizo el estudio\n• De qué trató\n• Qué encontró\n• Por qué es relevante para otra investigación.',
                                  ),
                                ],
                              ),
                            ),
                          Text(
                            textos[_index],
                            style: TextStyle(
                              fontSize: tamanotexto(2) + 4,
                              fontFamily: 'Calibri',
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),

                          const SizedBox(height: 10),

                          /*if (_index == 4)
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
                                  TextSpan(text: ''),
                                  TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () async {
                                            await abrirLink('');
                                          },
                                  ),
                                ],
                              ),
                            ),*/
                          const SizedBox(height: 20),
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
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          TextSpan(
                                            text: 'Antecedente 1: \n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'En 2020, María Pérez realizó un estudio sobre el uso del celular en estudiantes de secundaria. Su investigación mostró que los jóvenes pasan en promedio 4 horas al día usando redes sociales. '
                                                'Este estudio es importante porque ayuda a entender cómo el uso del celular afecta el tiempo de estudio de los estudiantes.\n',
                                          ),

                                          TextSpan(
                                            text:
                                                'Este es un ejemplo básico que muestra:\n• Quién hizo el estudio\n• De qué trató\n• Qué encontró\n• Por qué es relevante para otra investigación.',
                                          ),
                                        ],
                                      ),
                                    ),
                                  Text(
                                    textos[_index],
                                    style: TextStyle(
                                      fontSize: tamanotexto(2) + 4,
                                      fontFamily: 'Calibri',
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(height: 10),

                                  /*if (_index == 4)
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
                                          TextSpan(text: ''),
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () async {
                                                    await abrirLink('');
                                                  },
                                          ),
                                        ],
                                      ),
                                    ),*/
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 0,
                            child: Align(
                              alignment: Alignment.topRight,
                              // Alinear imagen a la derecha.
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  imagenes[_index], // Imagen dinámica.
                                  height: alturaImagengrande[_index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                    MaterialPageRoute(builder: (context) => Objetivo()),
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
                  fontSize: tamanotexto(2),
                  fontFamily: 'Calibri',
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
                  //  await guardarProgresoFinal(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Metodologia()),
                  );
                }
              },

              icon: Icon(
                Icons.arrow_forward,
                color: obtenercolor('Color_Texto_Principal'),
                size: tamanotexto(2),
              ),
              label: Text(
                _index < secciones.length - 1 ? 'Siguiente' : 'Adelante',
                style: TextStyle(
                  color: obtenercolor('Color_Texto_Principal'),
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
          alignment: Alignment.bottomCenter,
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
      'id': 5,
      'text': 'Antecedentes',
      'icon': Icons.folder,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 6,
      'text': 'Ejemplo',
      'icon': Icons.book,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 7,
      'text': 'Estado del arte',
      'icon': Icons.search,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 8,
      'text': 'Ejemplo',
      'icon': Icons.text_fields,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
  ];
}
