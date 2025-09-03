// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/PlanteamientoProblemas/plantiamientoproblemas.dart';
import 'package:nuevomockups/global.dart';

class Titulo extends StatelessWidget {
  const Titulo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: const Titulos(),
    );
  }
}

class Titulos extends StatefulWidget {
  const Titulos({super.key});

  @override
  State<Titulos> createState() => _TitulosState();
}

class _TitulosState extends State<Titulos> with TickerProviderStateMixin {
  // ID único del subtema

  int _index = 0; //indica que las secciones inicia en la primera
  late TabController
  _tabController; //se usa un TabController para controlar las pestañas
  final List<int> pestanasVistas =
      []; // en esta variable se guarda las pestañas ya vistas

  final List<String> textos = [
    'El título de un proyecto de investigación es el nombre con el que se identifica dicho proyecto. El título debe ser conciso; debe estar formulado de modo tal que exprese con pocas palabras y de modo preciso, el objetivo de la investigación, las variables bajo consideración, la población o universo sobre la que se extenderán las conclusiones, y de ser necesario, dónde se llevará a cabo y cuándo.',
    'Características: debe ser preciso, Contener la idea principal del tema de investigación, Debe responder a: ¿Qué se va a hacer? ¿Sobre qué o quiénes se hará? ¿Dónde se llevará a cabo?, El título del proyecto se estructura en tres partes: Proceso: La acción o acciones a desarrollar. Objeto: El motivo del proceso. Localización: La ubicación geográfica de la investigación.',
    'Se recomienda usar entre 12-20 palabras, Ser limitativo: Si son fechas: Especificar el periodo de tiempo o la época, Si son personas: Edad, género, profesión, etc., Si son lugares: Colonia, localidad, municipio, estado, país, Si son teorías o corrientes: Especificar la ciencia que se aplica, Evitar la sobre explicación.',
    'Palabras útiles para estructurar el título.',
    'Ejemplos para la creación de un título:',
  ];

  final List<String> imagenes = [
    'assets/titulo/titulo.png',
    'assets/titulo/titulo_caracterisitcas.png',
    'assets/titulo/Titulo_otras_caracteristicas.jpg',
    'assets/titulo/Titulo_palabras_utiles.png',
    'assets/titulo/Titulo_ejemplo.png',
  ];

  // ignore: unused_field
  int _currentseccion = 0;

  final List<String> secciones = [
    'TÍTULO',
    'CARACTERÍSTICAS DEL TÍTULO',
    'MÁS CARACTERÍSTICAS DEL TÍTULO',
    'PALABRAS ÚTILES PARA TÍTULO',
    'EJEMPLOS DE TÍTULO',
  ];

  /*int _progresoContador = 1;
  // contador para el progreso, inicia en 1 porque la primera pestaña ya se ha visto
  double get progreso {
    return _progresoContador / secciones.length;
  } // se usa el contador para calcular el progreso*/

  final List<double> alturaImagengrande = [
    220, //TITULO
    240, // CARACTERISTICAS DEL TITULO
    260, //MAS CARACTERISTICAS DEL TITULO
    350, // PALABRAS UTILES PARA TITULO
    450, //EJEMPLOS DE TITULOS
  ];
  final List<double> alturaImagenPequena = [
    180, //TITULO
    180, // CARACTERISTICAS DEL TITULO
    200, //MAS CARACTERISTICAS DEL TITULO
    450, // PALABRAS UTILES PARA TITULO
    450, //EJEMPLOS DE TITULOS
  ];
  static int ID_BASE_PROGRESO = 1;

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
                color: obtenercolor('Color_Texto_Principal'),
                fontSize: tamanotexto(2),
              ),
            ),
          ),
        ],
      ),
      drawer: const Menu(currentScreen: 'Titulo'),
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
                            _buildHeader(),
                            const SizedBox(height: 20),
                            _buildTimelineCard(),
                          ],
                        ),
                      )
                      : Column(
                        // 📌 Sin zoom en pantallas grandes
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 20),
                          _buildTimelineCard(),
                        ],
                      ),
            ),
          ),
          _buildNavigation(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: obtenercolor('Color_Fondo'),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '¿Sabes cómo crear un Título?',
          style: TextStyle(
            fontSize: tamanotexto(1) + 5,
            fontFamily: 'Calibri',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTimelineCard() {
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
            padding: const EdgeInsets.all(24),
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
                  ),
                ),
                const SizedBox(height: 20),
                esPantallaPequena
                    ? Column(
                      // se usa ? como un operador ternario para saber si la pantalla es pequeña o grande
                      children: [
                        Text(
                          textos[_index],
                          style: TextStyle(
                            fontSize: tamanotexto(2),
                            fontFamily: 'Calibri',
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
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
                          //se usa expanded para establecer el tamaño del texto
                          flex: 2,
                          //se usa flex para que la imagen ocupe el 2/3 de la pantalla
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              textos[_index],
                              style: TextStyle(
                                fontSize: tamanotexto(2),
                                fontFamily: 'Calibri',
                                height: 1.5,
                                //se usa height para aumentar la altura de la letra
                              ),
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
                      ],
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: obtenercolor('Color_Fondo'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_index > 0)
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  _tabController.animateTo(_index - 1);
                  setState(() {
                    _currentseccion = _index - 1;
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: obtenercolor('Color_Texto_Principal'),
                  size: tamanotexto(2),
                ),
                label: Text(
                  'Anterior',
                  style: TextStyle(
                    color: obtenercolor('Color_texto_principal'),
                    fontSize: tamanotexto(2),
                  ),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.zero,
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((
                    Set<MaterialState> states,
                  ) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color(0xFF50E5F9); // Hover (celeste)
                    }
                    return obtenercolor('Color_Principal'); // Normal (verde)
                  }),
                ),
              ),
            )
          else
            const SizedBox(),
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
                      builder: (context) => const Plantiamientoproblemas(),
                    ),
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
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.resolveWith<Color>((
                  Set<MaterialState> states,
                ) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color(0xFF50E5F9); // Hover (celeste)
                  }
                  return obtenercolor('Color_Principal'); // Normal (verde)
                }),
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
      'text': 'Título',
      'icon': Icons.title,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Características',
      'icon': Icons.info,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Más Características',
      'icon': Icons.list_alt,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
    {
      'id': 5,
      'text': 'Palabras Útiles',
      'icon': Icons.text_fields,
      'color': obtenercolor('Color_Secundario'),
      'indice': 3,
    },
    {
      'id': 6,
      'text': 'Ejemplos',
      'icon': Icons.book,
      'color': obtenercolor('Color_Secundario'),
      'indice': 4,
    },
  ];
}
