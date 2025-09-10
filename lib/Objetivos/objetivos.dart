// ignore_for_file: unused_field, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Justificacion/justificacion.dart';
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
    'Una de las grandes ventajas de la gestión de proyectos es que te permite visualizar tu trabajo en'
        ' un cronograma de actividades y no en una hoja de cálculo o lista de pendientes desorganizada. Con'
        ' un cronograma de actividades, tienes una idea clara de cómo encajan todas las piezas de tu plan.'
        ' Entonces, ¿por qué no tienes uno aún? Sin la tecnología adecuada, crear un cronograma de actividades'
        ' de tu proyecto puede ser muy complicado.',

    'El modelo SMART –acrónimo que significa «inteligente» en inglés– hace referencia a cinco conceptos que hay'
        ' que tener presentes constantemente a la hora de fijar objetivos si lo que buscamos es validar su pertinencia.'
        ' Por orden, los conceptos son «específico» (S, specific), «medible» (M, measurable), «asignable» (A, assignable),'
        ' «realista» (R, realistic), «temporal» (T, time-related), es decir, determinado en el tiempo. Según Steffens, G.,'
        ' & Cadiat, A. C. (2016). Los criterios SMART: El método para fijar objetivos con éxito. 50Minutos.',

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
        ' entreguen valor a la empresa y a la marca..',

    'El árbol de objetivos reúne los medios y alternativas para solucionar el problema principal. Gracias a ello, se logra una visión positiva de las'
        ' situaciones negativas que aparecían en el árbol anterior, aunque utilice la misma estructura. Así, se busca ir resolviendo el problema paso a paso..',
  ];

  final List<String> imagenes = [
    'assets/Objetivos/Objetivos.png', //COMO CREAR LOS OBJETIVOS
    'assets/Objetivos/Objetivos_Método_Smart_Titulo.png', //MÉTODO SMART
    'assets/metodo_clear.png', //MÉTODO CLEAR
    'assets/metodo_pure.jpg', //MÉTODO PURE
    'assets/metodo_grow.jpg', //MÉTODO GROW
    'assets/metodo_dumb.png', //MÉTODO DUMB
    'assets/metodo_arbol.jpg', //ÁRBOL DE OJETIVOS
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

  final List<double> alturaImagengrande = [
    650, //COMO CREAR LOS OBJETIVOS
    300, //MÉTODO SMART
    500, //MÉTODO CLEAR
    150, //MÉTODO PURE
    150, //MÉTODO GROW
    400, //MÉTODO DUMB
    400, //ÁRBOL DE OJETIVOS
  ];

  final List<double> alturaImagenPequena = [
    500, //COMO CREAR LOS OBJETIVOS
    300, //MÉTODO SMART
    300, //MÉTODO CLEAR
    300, //MÉTODO PURE
    300, //MÉTODO GROW
    300, //MÉTODO DUMB
    300, //ÁRBOL DE OJETIVOS
  ];

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
      drawer: const Menu(currentScreen: 'Objetivos'),
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
                            _buildercard(),
                          ],
                        ),
                      )
                      : Column(
                        // 📌 Sin zoom en pantallas grandes
                        children: [
                          _buildHeader(),
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: obtenercolor('Color_Fondo'),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        // se usa BoxFit.scaleDown para que el texto se ajuste al tamaño del contenedor
        child: Text(
          '¿Sabes cómo crear los Objetivos?',
          style: TextStyle(
            color: Colors.black,
            fontSize: tamanotexto(1) + 5,
            fontWeight: FontWeight.bold,
            fontFamily: 'Calibri',
          ),
          textAlign: TextAlign.center,
        ),
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
                            fontSize: tamanotexto(2),
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
                    : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/fondo_textura_2.png'),
                          scale: 0.5,
                          opacity: 0.2,
                          alignment: Alignment.bottomLeft,
                          fit: BoxFit.none,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                textos[_index],
                                style: TextStyle(
                                  fontSize: tamanotexto(2),
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
                    ),
                if (_index == 1)
                  Center(
                    child: Image.asset(
                      height: 300,
                      'assets/Objetivos/Objetivos_Método_Smart_Texto.png',
                    ),
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
                      //await guardarProgresoFinal(ID_BASE_PROGRESO);
                    }
                  });
                } else {
                  //await guardarProgresoFinal(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Metodologia(),
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
