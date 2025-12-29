// ignore_for_file: unused_field, deprecated_member_use, non_constant_identifier_names

//import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Actividades/actividades.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Links/links.dart';

import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/Metodologia/metodologia.dart';
import 'package:nuevomockups/global.dart';

class Cronograma extends StatelessWidget {
  const Cronograma({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Cronogramas(),
    );
  }
}

class Cronogramas extends StatefulWidget {
  const Cronogramas({super.key});

  @override
  State<Cronogramas> createState() => _CronogramasState();
}

class _CronogramasState extends State<Cronogramas>
    with TickerProviderStateMixin {
  int _index = 0;
  late TabController _tabController;
  final List<int> pestanasVistas = [];

  final List<String> textos = [
    'Una de las grandes ventajas de la gestión de proyectos es que te permite visualizar tu trabajo en un cronograma'
        ' de actividades y no en una hoja de cálculo o lista de pendientes desorganizada. Con un cronograma de actividades,'
        ' tienes una idea clara de cómo encajan todas las piezas de tu plan. Entonces, ¿por qué no tienes uno aún? Sin la tecnología'
        ' adecuada, crear un cronograma de actividades de tu proyecto puede ser muy complicado.',
    '',
    '',
  ];
  final List<String> imagenes = [
    'assets/Cronograma/Cronograma_como_crear_un_Cronograma.png', //COMO CREAR UN CRONOGRAMA
    'assets/Cronograma/Cronograma_Pasos.png', //PASOS
    'assets/Cronograma/Cronograma_Ejemplo.png', //EJEMPLO
  ];

  final List<String> secciones = [
    'COMO CREAR UN CRONOGRAMA',
    'PASOS',
    'EJEMPLO',
  ];

  List<double> grande(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.2 - 18, //COMO CREAR UN CRONOGRAMA
      MediaQuery.of(context).size.width * 0.4 - 18, //PASOS
      MediaQuery.of(context).size.width * 0.53 - 18, //EJEMPLO
    ];
  }

  List<double> Pequena(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.3 - 18, //COMO CREAR UN CRONOGRAMA
      MediaQuery.of(context).size.width * 0.5 - 18, //PASOS
      MediaQuery.of(context).size.width * 0.6 - 18, //EJEMPLO
    ];
  }

  static int ID_BASE_PROGRESO = 43;
  int _currentseccion = 0;

  @override
  @override
  void initState() {
    super.initState();

    // Registro la primera pestaña como visitada al iniciar la pantalla
    pestanasVistas.add(0);

    // Marco la primera pestaña en el progreso global usando el ID base
    ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + 0);

    // Inicializo el controlador de pestañas según la cantidad de secciones
    _tabController = TabController(
      length: secciones.length,
      vsync: this,
    );

    // Escucho los cambios de pestaña para actualizar el estado y el progreso
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _index = _tabController.index);

        // Registro la pestaña como visitada si aún no ha sido marcada
        if (!pestanasVistas.contains(_tabController.index)) {
          pestanasVistas.add(_tabController.index);
          ProgresoGlobal.marcarVisto(
            ID_BASE_PROGRESO + _tabController.index,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ahora el nombre refleja la condición real
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
        currentScreen: 'Cronograma',
        progreso: ProgresoGlobal.porcentaje,
      ),
      body: Stack(
        children: [
          // Fondo superior izquierda decorativo
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Cronograma/Fondo_superior_Derecha.png',
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
                'assets/Icono_Planeta.png',
                width: esPantallaPequena ? 45 : 108,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Fondo superior derecha decorativo
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Cronograma/Fondo_Supeior_Izquierda.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Fondo inferior izquierda
          Positioned(
            bottom: 90,
            left: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Cronograma/Fondo_inferior_Izquierda.png',
                width: esPantallaPequena ? 120 : 250,
                //height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Fondo inferior derecha
          Positioned(
            bottom: 90,
            right: 0,
            child: Opacity(
              opacity: opacidad(1),
              child: Image.asset(
                'assets/Cronograma/Fondo_Inferior_Derecha.png',
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
                'assets/Icono_T_Ensayo.png',
                width: esPantallaPequena ? 45 : 90,
                //MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Contenido principal
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
                              // Zoom solo en pantallas pequeñas
                              constrained: true,
                              minScale: 1.0,
                              maxScale: 5.0,
                              child: Column(
                                children: [
                                  Text(
                                    '¿Sabes como crear un Cronograma?',
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
                              // En pantallas grandes sin zoom
                              children: [
                                Text(
                                  '¿Sabes como crear un Cronograma?',
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

                  // Navegación inferior
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
                            Text(
                              textos[_index],
                              style: TextStyle(
                                fontSize: tamanotexto(2),
                                fontFamily: 'Calibri',
                                height: 1.5,
                              ),
                              textAlign: TextAlign.justify,
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
                                child: Column(
                                  children: [
                                    if (_index != 2)
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
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        imagenes[_index],
                                        height: alturaImagengrande[_index],
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (_index == 1) Spacer(),
                            if (_index == 1) Spacer(),
                            if (_index == 2)
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                          ],
                        ),
                  if (_index == 2)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    abrirLink(
                                      'https://youtu.be/L0WrJUFkRKs',
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

  // Construye la barra de navegación inferior con los botones Anterior y Siguiente
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
                // Si no estoy en la primera sección, retrocedo una pestaña
                if (_index > 0) {
                  final anterior = _index - 1;
                  _tabController.animateTo(anterior);
                  setState(() {
                    _index = anterior;

                    // Registro la pestaña como visitada y actualizo el progreso
                    if (!pestanasVistas.contains(anterior)) {
                      pestanasVistas.add(anterior);
                      ProgresoGlobal.marcarVisto(ID_BASE_PROGRESO + anterior);
                    }
                  });
                } else {
                  // Si estoy en la primera sección, regreso a la pantalla de Metodología
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Metodologia(),
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
                // Si no estoy en la última sección, avanzo a la siguiente
                if (_index < secciones.length - 1) {
                  _tabController.animateTo(_index + 1);

                  // Actualizo primero el estado visual de la sección actual
                  setState(() {
                    _currentseccion = _index + 1;
                  });

                  // Actualizo el progreso de forma persistente
                  int idReal = ID_BASE_PROGRESO + _index + 1;

                  if (!ProgresoGlobal.pestanasVistas.contains(idReal)) {
                    ProgresoGlobal.pestanasVistas.add(idReal);
                    await ProgresoGlobal.guardarLocal();
                    await guardarProgresoEnAPI(idReal);
                  }
                } else {
                  // Si ya es la última sección, navego a la pantalla de Actividades
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Actividades(),
                    ),
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
                // Muestra “Siguiente” mientras existan secciones por recorrer,
                // y “Adelante” cuando se llega a la última
                _index < secciones.length - 1 ? 'Siguiente' : 'Adelante',
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

  // Muestra un menú modal inferior que contiene un menú horizontal de navegación
  void modalmenu(BuildContext context) {
    showModalBottomSheet(
      context: context,

      // Permite que el modal ajuste su tamaño según el contenido
      isScrollControlled: true,

      // Defino las restricciones de tamaño del modal
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3, // Altura máxima
        minHeight: 0, // Altura mínima
        maxWidth: MediaQuery.of(context).size.width, // Ancho máximo
        minWidth: 0, // Ancho mínimo
      ),

      // Uso fondo transparente para personalizar el contenedor interno
      backgroundColor: Colors.transparent,

      builder: (x) {
        return Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Container(
            decoration: BoxDecoration(
              color: obtenercolor('Color_Fondo'),

              // Aplico bordes redondeados solo en la parte superior
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),

            // Construyo el contenido principal del menú
            child: _buildGridMenu(context),
          ),
        );
      },
    );
  }

// Construye el menú horizontal con scroll para la navegación entre secciones
  Widget _buildGridMenu(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Determino si la pantalla es grande (web o tablet)
    final bool esPantallaGrande = kIsWeb || screenWidth > 600;

    // Controlador del scroll horizontal
    final ScrollController scrollController = ScrollController();

    // Ajusto el tamaño de los items según el tipo de pantalla
    final double itemWidth = esPantallaGrande ? 180 : 120;
    final double itemSpacing = 24; // Margen horizontal total (12 + 12)

    // Calculo el ancho total del contenido
    final double totalContentWidth =
        (itemWidth + itemSpacing) * menuItems.length;

    // Si el contenido no ocupa todo el ancho, lo centro
    double sidePadding = 0;
    if (totalContentWidth < screenWidth) {
      sidePadding = (screenWidth - totalContentWidth) / 2;
    }

    return SizedBox(
      height: 190, // Altura fija del menú
      child: Scrollbar(
        controller: scrollController,

        // Mantengo visible el scrollbar para mejorar la experiencia de usuario
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

            // Verifico si la pestaña ya fue visitada
            final bool isVisited = pestanasVistas.contains(item['indice']);

            // Verifico si la pestaña está actualmente seleccionada
            final bool isSelected = _tabController.index == item['indice'];

            return SizedBox(
              width: itemWidth,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {
                    // Cierro el modal antes de cambiar de sección
                    Navigator.pop(context);

                    final nuevoIndex = item['indice'];
                    if (nuevoIndex != null) {
                      // Cambio de pestaña con animación
                      _tabController.animateTo(nuevoIndex);

                      setState(() {
                        _index = nuevoIndex;

                        // Registro la pestaña como visitada y actualizo el progreso
                        if (!pestanasVistas.contains(nuevoIndex)) {
                          pestanasVistas.add(nuevoIndex);
                          ProgresoGlobal.marcarVisto(item['id']);
                        }
                      });
                    }
                  },

                  // Define la apariencia visual de cada item del menú
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // El color cambia si la pestaña está seleccionada o visitada
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

                      // Texto descriptivo de la sección
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
      'text': 'Como crear un Cronograma',
      'icon': Icons.calendar_today,
      'color': obtenercolor('Color_Secundario'),
      'indice': 0,
    },
    {
      'id': 3,
      'text': 'Pasos',
      'icon': Icons.directions_walk,
      'color': obtenercolor('Color_Secundario'),
      'indice': 1,
    },
    {
      'id': 4,
      'text': 'Ejemplo',
      'icon': Icons.check_circle_outline,
      'color': obtenercolor('Color_Secundario'),
      'indice': 2,
    },
  ];
}
