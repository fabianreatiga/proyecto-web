// ignore_for_file: unused_field, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Antecedentes_Estado/antecedentesoestado.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Cronograma/cronograma.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Menus/menus.dart';

import 'package:nuevomockups/global.dart';

class Metodologia extends StatelessWidget {
  const Metodologia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Metodologias(),
    );
  }
}

class Metodologias extends StatefulWidget {
  const Metodologias({super.key});

  @override
  State<Metodologias> createState() => _MetodologiasState();
}

class _MetodologiasState extends State<Metodologias>
    with TickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;
  final List<int> pestanasVistas = [];

  final List<String> textos = [
    'La metodología de investigación es la estrategia que se utilizará para que un proyecto de investigación sea exitoso por'
        ' lo que su elección determina todo el rumbo de la investigación. La mejor metodología que deba usarse, sin embargo, es'
        ' una las decisiones más difíciles para los investigadores por lo que es importante conocer los factores que influyen en'
        ' la decisión, las metodologías de investigación que existen y qué pasos seguir para poder seleccionar la mejor de acuerdo'
        ' con la investigación que se tenga en mente.',
    'Las metodologías de investigación pueden ser:',
    'Investigación Cualitativa: Las metodologías cualitativas se utilizan para responder cuestionamientos que no pueden ser'
        ' medibles y se enfocan en obtener información de experiencias y percepciones de los participantes que interesan a la investigación.',
    'Investigación Cuantitativa: Las metodologías cuantitativas son aquéllas con las que se pueden obtener datos cuantitativos o'
        ' medibles. Su importancia es que pueden validarse con modelos y principios científicos, pero pueden llegar a ser inflexibles y frías.',
    'Investigación Mixta: Las metodologías mixtas son aquéllas que combinan tanto las metodologías cualitativas como las cuantitativas.'
        ' En años recientes, los investigadores prefieren las metodologías mixtas porque les dan la oportunidad de llevar a cabo investigaciones'
        ' cualitativas y cuantitativas en paralelo. Sin embargo, también pueden resultar más costosas, complejas y tomar mayor tiempo que las'
        ' metodologías cualitativas y cuantitativas por separado. Dependiendo de su investigación podría pensar en combinar dos o más tipos'
        ' diferentes de las metodologías anteriores considerando al menos una metodología cualitativa y una cuantitativa.',
    '',
  ];
  final List<String> imagenes = [
    'assets/Metodologia/Metodologia_Metodologia.png', //METODOLOGÍA
    'assets/Metodologia/Metodologia_Tipos_De_Metodologia.png', //TIPOS DE METODOLOGÍAS
    'assets/Metodologia/Metodologia_Tipos_De_Metodologia_Cualitativa.png', //CUALITATIVA
    'assets/Metodologia/Metodologia_Tipos_De_Metodologia_Cuantitativa.png', //CUANTITATIVA
    'assets/Metodologia/Metodologia_Tipos_De_Metodologia_Mixta.png', //MIXTA
    'assets/Metodologia/Metodologia_Pasos_Crear.png', //PASOS PARA CREAR
  ];

  final List<String> secciones = [
    'METODOLOGÍA',
    'TIPOS DE METODOLOGÍAS',
    'CUALITATIVA',
    'CUANTITATIVA',
    'MIXTA',
    'PASOS PARA CREAR',
  ];

  /*int _progresoContador = 1;
  double get progreso {
    return _progresoContador / secciones.length;
  }*/

  List<double> agrande(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.15 - 18, //METODOLOGÍA
      250, //TIPOS DE METODOLOGÍAS
      300, //CUALITATIVA
      300, //CUANTITATIVA
      300, //MIXTA
      MediaQuery.of(context).size.width * 0.35 - 18, //PASOS PARA CREAR
    ];
  }

  List<double> Pequena(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.25 - 18, //METODOLOGÍA
      300, //TIPOS DE METODOLOGÍAS
      300, //CUALITATIVA
      300, //CUANTITATIVA
      300, //MIXTA
      MediaQuery.of(context).size.width * 0.63 - 18, //PASOS PARA CREAR
    ];
  }

  static int ID_BASE_PROGRESO = 37;
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
                color: obtenercolor('Color_Tetxto_Principal'),
                fontWeight: FontWeight.bold,
                fontSize: tamanotexto(2),
              ),
            ),
          ),
        ],
      ),
      drawer: Menu(
        currentScreen: 'Metodologia',
        progreso: ProgresoGlobal.porcentaje,
      ),
      body: Stack(
        children: [
          // 🌄 Fondo superior izquierda decorativo
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Metodologia/Fondo_superior_Derecha.png',
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
                'assets/Icono_Cohete.png',
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
                'assets/Metodologia/Fondo_Supeior_Izquierda.png',
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
                'assets/Metodologia/Fondo_inferior_Izquierda.png',
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
                'assets/Metodologia/Fondo_Inferior_Derecha.png',
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
                'assets/Icono_Microscopio.png',
                width: esPantallaPequena ? 45 : 70,
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
                      child: esPantallaPequena
                          ? InteractiveViewer(
                              // 🔍 Zoom solo en pantallas pequeñas
                              constrained: true,
                              minScale: 1.0,
                              maxScale: 5.0,
                              child: Column(
                                children: [
                                  Text(
                                    '¿Sabes como crear una buena Metodología?',
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
                                  '¿Sabes como crear una buena Metodología?',
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
        final alturaImagengrande = agrande(context);
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
                    ),
                  ),
                  const SizedBox(height: 20),
                  esPantallaPequena
                      ? Column(
                          // se usa Column para mostrar el texto en dos filas
                          children: [
                            if (_index == 2)
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
                                      text: 'Investigación Cualitativa: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Las metodologías cualitativas se utilizan para responder cuestionamientos que no pueden ser'
                                          ' medibles y se enfocan en obtener información de experiencias y percepciones de los participantes que interesan a la investigación.',
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
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Investigación Cuantitativa: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Las metodologías cuantitativas son aquéllas con las que se pueden obtener datos cuantitativos o'
                                          ' medibles. Su importancia es que pueden validarse con modelos y principios científicos, pero pueden llegar a ser inflexibles y frías.',
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
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Investigación Mixta: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Las metodologías mixtas son aquéllas que combinan tanto las metodologías cualitativas como las cuantitativas.'
                                          ' En años recientes, los investigadores prefieren las metodologías mixtas porque les dan la oportunidad de llevar a cabo investigaciones'
                                          ' cualitativas y cuantitativas en paralelo. Sin embargo, también pueden resultar más costosas, complejas y tomar mayor tiempo que las'
                                          ' metodologías cualitativas y cuantitativas por separado. Dependiendo de su investigación podría pensar en combinar dos o más tipos'
                                          ' diferentes de las metodologías anteriores considerando al menos una metodología cualitativa y una cuantitativa.',
                                    ),
                                  ],
                                ),
                              ),
                            if (_index != 2 && _index != 3 && _index != 4)
                              Text(
                                textos[_index],
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'calibri',
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                children: [
                                  Image.asset(
                                    imagenes[_index],
                                    height: alturaImagenPequena[_index],
                                    fit: BoxFit.contain,
                                  ),
                                  if (_index == 5)
                                    Image.asset(
                                      'assets/Metodologia/Metodologia_Pasos_Crear2.png',
                                      fit: BoxFit.contain,
                                    ),
                                ],
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
                                    if (_index == 2)
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
                                              text:
                                                  'Investigación Cualitativa: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Las metodologías cualitativas se utilizan para responder cuestionamientos que no pueden ser'
                                                  ' medibles y se enfocan en obtener información de experiencias y percepciones de los participantes que interesan a la investigación.',
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
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Investigación Cuantitativa: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Las metodologías cuantitativas son aquéllas con las que se pueden obtener datos cuantitativos o'
                                                  ' medibles. Su importancia es que pueden validarse con modelos y principios científicos, pero pueden llegar a ser inflexibles y frías.',
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
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Investigación Mixta: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Las metodologías mixtas son aquéllas que combinan tanto las metodologías cualitativas como las cuantitativas.'
                                                  ' En años recientes, los investigadores prefieren las metodologías mixtas porque les dan la oportunidad de llevar a cabo investigaciones'
                                                  ' cualitativas y cuantitativas en paralelo. Sin embargo, también pueden resultar más costosas, complejas y tomar mayor tiempo que las'
                                                  ' metodologías cualitativas y cuantitativas por separado. Dependiendo de su investigación podría pensar en combinar dos o más tipos'
                                                  ' diferentes de las metodologías anteriores considerando al menos una metodología cualitativa y una cuantitativa.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (_index != 2 &&
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
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        imagenes[_index],
                                        height: alturaImagengrande[_index],
                                        fit: BoxFit.contain,
                                      ),
                                      if (_index == 5)
                                        Image.asset(
                                          'assets/Metodologia/Metodologia_Pasos_Crear2.png',
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3 -
                                              18,
                                          fit: BoxFit.contain,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (_index == 5)
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1 -
                                    18,
                              ),
                            if (_index == 1) SizedBox(width: 150),
                            if (_index == 5) Spacer(),
                          ],
                        ),
                  if (_index == 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
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
                            ],
                          ),
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
                      builder: (context) => const Antecedentes_Estados(),
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

                  // 1. Actualizamos UI primero
                  setState(() {
                    _currentseccion = _index + 1;
                  });

                  // 2. Actualizamos progreso (fuera de setState)
                  int idReal = ID_BASE_PROGRESO + _index + 1;

                  if (!ProgresoGlobal.pestanasVistas.contains(idReal)) {
                    ProgresoGlobal.pestanasVistas.add(idReal);
                    await ProgresoGlobal.guardarLocal();

                    // print("🟢 Progreso sumado → ID: $idReal");

                    // 🟢 GUARDAR EN MONGODB
                    await guardarProgresoEnAPI(idReal);
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cronograma()),
                  );
                  ProgresoGlobal.marcarVisto(2);
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
        maxHeight: MediaQuery.of(context).size.height *
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
                          color: (isSelected || isVisited)
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
                          color: (isSelected || isVisited)
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
      'text': 'Metodoligía',
      'icon': Icons.settings_suggest,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Tipo de Metodología',
      'icon': Icons.category,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Cualitativa',
      'icon': Icons.psychology_alt,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 6,
      'text': 'Cuantitativa',
      'icon': Icons.bar_chart,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
    {
      'id': 7,
      'text': 'Mixta',
      'icon': Icons.merge_type,
      'color': obtenercolor('Color_Secundario'),
      'indice': 4,
    },
    {
      'id': 8,
      'text': 'Pasos para crear',
      'icon': Icons.directions_walk,
      'color': obtenercolor('Color_Secundario'),
      'indice': 5,
    },
  ];
}
