// ignore_for_file: unused_field, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Bibliografia/bibliografia.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Cronograma/cronograma.dart';

import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/global.dart';

class Actividades extends StatelessWidget {
  const Actividades({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Actividad(),
    );
  }
}

class Actividad extends StatefulWidget {
  const Actividad({super.key});

  @override
  State<Actividad> createState() => _ActividadState();
}

class _ActividadState extends State<Actividad> with TickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;
  final List<int> pestanasVistas = [];

  final List<String> textos = [
    'Las actividades del proyecto se crean para cada una de las fases con el fin de alcanzar los'
        ' objetivos propuestos indicando tiempos y roles de ejecución.',
    'Los resultados esperados son los productos tangibles que el proyecto mismo debe producir para'
        ' alcanzar sus objetivos. Por objetivo debe haber mínimo un resultado esperado',
    '• Se deben especificar los resultados esperados en el orden y en el período de tiempo en el cual'
        ' se pretenden alcanzar.\n• Se formulan en términos de los efectos o impactos que pueden generarse a'
        ' nivel social, medioambiental, de políticas públicas, etc.',
  ];
  final List<String> imagenes = [
    'assets/Actividades/Actividades.png', //ACTIVIDADES
    'assets/Actividades/Actividades_Resultados.png', //RESULTADOS
    'assets/Actividades/Actividades_Formulacion_De_Resultados.png', //FORMULACIÓN DE RESULTADOS
  ];

  final List<String> secciones = [
    'ACTIVIDADES',
    'RESULTADOS',
    'FORMULACIÓN DE RESULTADOS',
  ];

  //  int _progresoContador = 1;
  //  double get progreso {
  //return _progresoContador / secciones.length;
  //}

  final List<double> alturaImagengrande = [
    450, //ACTIVIDADES
    350, //RESULTADOS
    450, //FORMULACIÓN DE RESULTADOS
  ];

  final List<double> alturaImagenPequena = [
    300, //ACTIVIDADES
    300, //RESULTADOS
    300, //FORMULACIÓN DE RESULTADOS
  ];

  static int ID_BASE_PROGRESO = 41;
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
    final bool esPantallaPequena = MediaQuery.of(context).size.width < 850;

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
      drawer: const Menu(currentScreen: 'Actividades'),
      body: Column(
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
                              '¿Sabes que son las Actividades o resultados?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: tamanotexto(1) + 5,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Calibri',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            _buildercard(),
                          ],
                        ),
                      )
                      : Column(
                        // 📌 Sin zoom en pantallas grandes
                        children: [
                          Text(
                            '¿Sabes que son las Actividades o resultados?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: tamanotexto(1) + 5,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Calibri',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          _buildercard(),
                        ],
                      ),
            ),
          ),
          _buildNavigation(),
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
                          Text(
                            textos[_index],
                            style: TextStyle(
                              fontSize: tamanotexto(2) + 4,
                              fontFamily: 'Calibri',
                              height: 1.5,
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
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                textos[_index],
                                style: TextStyle(
                                  fontSize: tamanotexto(2) + 4,
                                  fontFamily: 'calibri',
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
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
                    MaterialPageRoute(builder: (context) => const Cronograma()),
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
                  await guardarProgresoFinal(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Bibliografia(),
                    ),
                  );
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
    // en esta linea de codigo se obtiene el ancho de la pantalla
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
      height: 190, // un poco más para dar espacio a la barra
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true, //esta linea es para mostrar la barra
        trackVisibility: true,
        interactive: true, //esta linea es para habilitar click & drag
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
              width: esPantallaGrande ? 180 : 120,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  //se usa GestureDetector para detectar el click
                  onTap: () {
                    Navigator.pop(context);
                    final nuevoIndex = item['indice'];
                    if (nuevoIndex != null) {
                      _tabController.animateTo(nuevoIndex);
                      setState(() {
                        _index = nuevoIndex;
                        if (!pestanasVistas.contains(nuevoIndex)) {
                          pestanasVistas.add(nuevoIndex);
                          // _progresoContador++;
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
      'text': 'Actividades',
      'icon': Icons.work_outline,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Resultados',
      'icon': Icons.task_alt,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Formulacion de Resultados',
      'icon': Icons.summarize,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
  ];
}
