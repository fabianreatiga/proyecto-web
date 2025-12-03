// ignore_for_file: unused_field, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Actividades/actividades.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Busqueda/busqueda.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/global.dart';

class Bibliografia extends StatelessWidget {
  const Bibliografia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Bibliografias(),
    );
  }
}

class Bibliografias extends StatefulWidget {
  const Bibliografias({super.key});

  @override
  State<Bibliografias> createState() => _BibliografiasState();
}

class _BibliografiasState extends State<Bibliografias>
    with TickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;
  final List<int> pestanasVistas = [];

  final List<String> textos = [
    'Citas bibliográficas su importancia',
    'Para entender mejor esto, lo invitamos a ver los siguientes 2 ejemplos que ilustran mejor lo dicho:',
    'Para entender mejor esto, lo invitamos a ver los siguientes 2 ejemplos que ilustran mejor lo dicho:',
    'Ejemplos diferentes usos.',
    'Las normas IEEE determinan y se recomienda tener en cuenta:',
    'Ejemplos diferentes usos.',
    'Para ampliar el manejo del estilo APA se recomienda consultar los siguientes sitios web:\n',
  ];
  final List<String> imagenes = [
    'assets/bibliografia/Bibliografia.png', //BIBLIOGRAFÍA
    'assets/bibliografia/Bibliografia_ejemplo.png', //EJEMPLOS
    'assets/bibliografia/Bibliografia_Normas_APA.png', //NORMAS APA
    'assets/bibliografia/Bibliografia_Ejemplo_APA.png', //EJEMPLOS APA
    'assets/bibliografia/Bibliografia_Normas_IEEE.png', //NORMAS IEEE
    'assets/bibliografia/BiblioGrafia_Ejemplo_IEEE.png', //EJEMPLOS IEEE
    'assets/bibliografia/Bibliografia_Sitios_Web_Recomendados.png', //SITIOS WEB RECOMENDADOS
  ];

  final List<String> secciones = [
    'BIBLIOGRAFÍA',
    'EJEMPLOS',
    'NORMAS APA',
    'EJEMPLOS APA',
    'NORMAS IEEE',
    'EJEMPLOS IEEE',
    'SITIOS WEB RECOMENDADOS',
  ];

  /*int _progresoContador = 1;
  double get progreso {
    return _progresoContador / secciones.length;
  }*/

  List<double> grande(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.5 - 18, //BIBLIOGRAFÍA
      MediaQuery.of(context).size.width * 0.37 - 18, //EJEMPLOS
      MediaQuery.of(context).size.width * 0.38 - 18, //NORMAS APA
      MediaQuery.of(context).size.width * 0.48 - 18, //EJEMPLOS APA
      MediaQuery.of(context).size.width * 0.35 - 18, //NORMAS IEEE
      MediaQuery.of(context).size.width * 0.65 - 18, //EJEMPLOS IEEE
      MediaQuery.of(context).size.width * 0.37 - 18, //SITIOS WEB RECOMENDADOS
    ];
  }

  List<double> Pequena(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.7 - 18, //BIBLIOGRAFÍA
      MediaQuery.of(context).size.width * 0.5 - 18, //EJEMPLOS
      MediaQuery.of(context).size.width * 0.5 - 18, //NORMAS APA
      MediaQuery.of(context).size.width * 0.7 - 18, //EJEMPLOS APA
      MediaQuery.of(context).size.width * 0.58 - 18, //NORMAS IEEE
      MediaQuery.of(context).size.width * 0.9 - 18, //EJEMPLOS IEEE
      MediaQuery.of(context).size.width * 0.5 - 18, //SITIOS WEB RECOMENDADOS
    ];
  }

  static int ID_BASE_PROGRESO = 49;
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
      drawer: const Menu(currentScreen: 'Bibliogafia'),
      body: Stack(
        children: [
          // 🌄 Fondo superior izquierda decorativo
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/bibliografia/Fondo_superior_Derecha.png',
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
                'assets/Icono_Atomo.png',
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
                'assets/bibliografia/Fondo_Supeior_Izquierda.png',
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
                'assets/bibliografia/Fondo_inferior_Izquierda.png',
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
                'assets/bibliografia/Fondo_Inferior_Derecha.png',
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
                'assets/Icono_Cohete.png',
                width: esPantallaPequena ? 45 : 110,
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
                                      '¿Sabes que es una Bibliografía?',
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
                                    '¿Sabes que es una Bibliografía?',
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
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                            abrirLink('');
                                          },
                                  ),
                                ],
                              ),
                            ),
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
                        crossAxisAlignment:
                            _index == 0 || _index == 3
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.center,

                        children: [
                          Expanded(
                            //se usa expanded para establecer el tamaño del texto
                            flex: 2,
                            //se usa flex para que la imagen ocupe el 2/3 de la pantalla
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  Text(
                                    textos[_index],
                                    style: TextStyle(
                                      fontSize: tamanotexto(2) + 4,
                                      fontFamily: 'Calibri',
                                      height: 1.5,
                                      //se usa height para aumentar la altura de la letra
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  if (_index == 6)
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
                                                    abrirLink('');
                                                  },
                                          ),
                                        ],
                                      ),
                                    ),
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
                                  // Altura para pantallas grandes.
                                  fit: BoxFit.contain,
                                  // se usa fit para que la imagen se ajuste al tamaño del contenedor
                                ),
                              ),
                            ),
                          ),

                          // Si index es 0 o 3, agregamos Spacer después para centrar
                          if (_index == 0 || _index == 3 || _index == 5)
                            Spacer(),
                          //if (_index == 0 /*|| _index == 3 || _index == 5*/ ) Spacer(),
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
                    MaterialPageRoute(
                      builder: (context) => const Actividades(),
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
          // Text('©Copyright SENA'),
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
                    MaterialPageRoute(builder: (context) => const Busqueda()),
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
      'text': 'Bibliografía',
      'icon': Icons.menu_book,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Ejemplos',
      'icon': Icons.description_outlined,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Normas APA',
      'icon': Icons.library_books,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 5,
      'text': 'Ejemplos APA',
      'icon': Icons.library_books,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
    {
      'id': 6,
      'text': 'Normas IEEE',
      'icon': Icons.rule,
      'color': obtenercolor('Color_Secundario'),
      'indice': 4,
    },
    {
      'id': 7,
      'text': 'Ejemplos IEEE',
      'icon': Icons.rule,
      'color': obtenercolor('Color_Secundario'),
      'indice': 5,
    },
    {
      'id': 8,
      'text': 'Sitios Web Recomendados',
      'icon': Icons.web,
      'color': obtenercolor('Color_Secundario'),
      'indice': 6,
    },
  ];
}
