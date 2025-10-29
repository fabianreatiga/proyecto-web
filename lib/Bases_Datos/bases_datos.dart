import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Bibliografia/bibliografia.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Encuesta/encuesta.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/global.dart';

import 'package:url_launcher/url_launcher.dart';

class Basesdatos extends StatelessWidget {
  const Basesdatos({super.key});

  @override
  Widget build(BuildContext context) {
    return Bassesdato();
  }
}

class Bassesdato extends StatefulWidget {
  const Bassesdato({super.key});

  @override
  State<Bassesdato> createState() => _BassesdatoState();
}

class _BassesdatoState extends State<Bassesdato> with TickerProviderStateMixin {
  // ID único del subtema

  int _index = 0; //indica que las secciones inicia en la primera
  late TabController
  _tabController; //se usa un TabController para controlar las pestañas
  final List<int> pestanasVistas =
      []; // en esta variable se guarda las pestañas ya vistas

  final List<String> textos = [
    '',
    '',
    '',
    '',
    '',
  ]; // lista de los textos que se van a mostrar

  final List<String> imagenes = ['', '', '', '', '']; // lista de las imagenes

  // ignore: unused_field
  int _currentseccion = 0;

  final List<String> secciones = ['', '', '', '', '']; // lista de las secciones

  final List<double> alturaImagengrande = [
    300, // OBJETIVO
    350, // BUSQUEDA EN GOOGLE CON OPERADORES LOGICOS Y PALABRAS CLAVE
    450, // GOOGLE ACADÉMICO (SCHOLAR)
    250, // ALERTAS DE GOOGLE
    350, // GOOGLE TENDENCIAS (TRENDS)
  ]; // lista de las alturas de las imagenes para pantallas grandes

  final List<double> alturaImagenPequena = [
    250, //OBJETIVO
    300, // BUSQUEDA EN GOOGLE CON OPERADORES LOGICOS Y PALABRAS CLAVE
    300, // GOOGLE ACADÉMICO (SCHOLAR)
    150, // ALERTAS DE GOOGLE
    250, // GOOGLE TENDENCIAS (TRENDS)
  ]; // lista de las alturas de las imagenes para pantallas pequenas

  static int ID_BASE_PROGRESO = 51; // ID base para el progreso de este subtema

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
    final bool esPantallaPequena = MediaQuery.of(context).size.width < 2000;

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

      // Een este bloque de codigo se usa para mostrar y navegar por el modal menu
      drawer: const Menu(currentScreen: 'Busqueda'),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child:
                    esPantallaPequena
                        ? InteractiveViewer(
                          // 📌 Zoom solo en pantallas pequeñas
                          constrained: true,
                          minScale: 1.0,
                          maxScale: 3.0,
                          child: Column(
                            children: [
                              Text(
                                '¿Sabes cómo hacer una búsqueda?',
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
                            ],
                          ),
                        )
                        : Column(
                          // 📌 Sin zoom en pantallas grandes
                          children: [
                            Text(
                              '¿Sabes cómo hacer una búsqueda?',
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
                          ],
                        ),
              ),
            ),
            _buildNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard() {
    // Función para abrir links correctamente en web y móvil
    Future<void> abrirLink(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode:
            kIsWeb
                ? LaunchMode.externalApplication
                : LaunchMode.platformDefault,
      )) {
        throw 'No se pudo abrir $url';
      }
    }

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
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  esPantallaPequena
                      ? Column(
                        children: [
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
                                        'Las alertas de Google son una herramienta gratuita que envía notificaciones al correo electrónico cuando aparece nueva información relacionada con un tema o palabra clave elegida. Para activarlas, se ingresa a ',
                                  ),
                                  TextSpan(
                                    text: 'google.com/alerts',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () async {
                                            await abrirLink(
                                              'https://www.google.com/alerts',
                                            );
                                          },
                                  ),
                                  TextSpan(
                                    text:
                                        ', se escribe el tema de interés, se ajustan las opciones (frecuencia, idioma, fuentes) y se presiona “Crear alerta”. Sirven para mantenerse informado automáticamente sobre noticias, investigaciones o temas específicos sin tener que buscarlos manualmente.',
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
                                    text:
                                        'Puedes acceder a la herramienta aquí: ',
                                  ),
                                  TextSpan(
                                    text: 'https://trends.google.com',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () async {
                                            await abrirLink(
                                              'https://trends.google.com',
                                            );
                                          },
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
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Puedes acceder a la herramienta aquí: ',
                                  ),
                                  TextSpan(
                                    text: 'https://scholar.google.com',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () async {
                                            await abrirLink(
                                              'https://scholar.google.com',
                                            );
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                                'Las alertas de Google son una herramienta gratuita que envía notificaciones al correo electrónico cuando aparece nueva información relacionada con un tema o palabra clave elegida. Para activarlas, se ingresa a ',
                                          ),
                                          TextSpan(
                                            text: 'google.com/alerts',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () async {
                                                    await abrirLink(
                                                      'https://www.google.com/alerts',
                                                    );
                                                  },
                                          ),
                                          TextSpan(
                                            text:
                                                ', se escribe el tema de interés, se ajustan las opciones (frecuencia, idioma, fuentes) y se presiona “Crear alerta”. Sirven para mantenerse informado automáticamente sobre noticias, investigaciones o temas específicos sin tener que buscarlos manualmente.',
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
                                            text:
                                                'Puedes acceder a la herramienta aquí: ',
                                          ),
                                          TextSpan(
                                            text: 'https://trends.google.com',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () async {
                                                    await abrirLink(
                                                      'https://trends.google.com',
                                                    );
                                                  },
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
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Puedes acceder a la herramienta aquí: ',
                                          ),
                                          TextSpan(
                                            text: 'https://scholar.google.com',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () async {
                                                    await abrirLink(
                                                      'https://scholar.google.com',
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
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bibliografia()),
                  );*/
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
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Encuesta()),
                  );*/
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
      'id': 2,
      'text': 'Objetivo',
      'icon': Icons.data_object,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Búsqueda en Google',
      'icon': Icons.info,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Google Académico (Scholar)',
      'icon': Icons.list_alt,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 5,
      'text': 'Aletas de Google',
      'icon': Icons.text_fields,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
    {
      'id': 6,
      'text': 'Google Tendencias (Trends)',
      'icon': Icons.book,
      'color': obtenercolor('Color_Secundario'),
      'indice': 4,
    },
  ];
}
