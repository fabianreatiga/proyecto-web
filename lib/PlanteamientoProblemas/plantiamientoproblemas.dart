// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Justificacion/justificacion.dart';
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
    'Tener en cuenta 1: ¿Qué es lo que se pretende conocer de un determinado objeto de estudio a partir de su '
        'investigación? 2: ¿De qué manera se piensa abordar la temática para esclarecer su desconocimiento?',
    'Se recomiendan estas 4 metodologías: 5W1H, Espina de pescado, Árbol de problemas, Esquema de redacción.',
    'Ejemplos: Qué (WHAT): Hay personas que sufren de los ojos, conjuntivitis alergénica y llevan aplicándose '
        'medicamento hace mucho tiempo sin curarse. Porqué (WHY): Porque los medicamentos que se aplican no son '
        'efectivos. Cuando (WHEN): Virosis de conjuntivitis, cuando hay altas tasas de polución y cuando se usa '
        'mucho los celulares o pantallas. Dónde (WHERE): Ciudades con mayor polución, en el campo durante las quemas '
        'y preparación, cuando cocina con leña, en personal de obra constructivo. En niños de etapa temprana. '
        'Quién (WHO): Personal de construcción, agricultores, niños, madres cabeza de familia que cocinan con '
        'leña, adultos mayores, personas que trabajan muchas horas desde la pantalla. Cómo (HOW): Medicamentos '
        'formulados, miel, otros remedios para los ojos. Cirugía.',
    'Basado en el análisis de los ítems anteriores se redacta un párrafo general con la descripción de '
        'la problemática identificada.',
    'Esquemas que pueden ayudar a plantear la problemática. 1. Para productos: Hemos observado que el '
        '[Producto o servicio] no está cumpliendo [con estos objetivos], lo cual está causando [efecto negativo] '
        'a nuestro [impacto en el negocio].',
    'Esquemas que pueden ayudar a plantear la problemática. 1. Cuándo es un punto de vista: [Tipo de usuario] '
        'intenta [descripción de su necesidad u objetivo] pero [barrera] porque [hallazgo] lo cual le hace sentir '
        '[efecto negativo].',
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
    'Estructura del Planteamiento del problema:',
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
    'assets/arbol_problemas.jpeg', // COMO HACER EL ÁRBOL DE PROBLEMAS
    'assets/ejemplo_arbol.jpg', // EJEMPLO ÁRBOL DE PROBLEMAS
    'assets/esquemas.jpeg', // ESQUEMA DE REDACCIÓN
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

  final List<double> alturaImagengrande = [
    300, // PLANTEAMIENTO DEL PROBLEMA
    325, // DEFINICIÓN
    300, // METODOLOGIAS
    350, // 5W1H
    400, // EJEMPLO 5W1H
    400, // EJEMPLO 2 5W1H
    400, // EJEMPLO 3 5W1H
    400, // ESPINA DE PESCADO
    450, // COMO HACER ESPINA DE PESCADO
    400, // EJEMPLO 1 ESPINA DE PESCADO
    400, // EJEMPLO 2 ESPINA DE PESCADO
    350, // ÁRBOL DE PROBLEMAS
    275, // COMO HACER EL ÁRBOL DE PROBLEMAS
    450, // EJEMPLO ÁRBOL DE PROBLEMAS
    280, // ESQUEMA DE REDACCIÓN
  ];
  final List<double> alturaImagenPequena = [
    300, // PLANTEAMIENTO DEL PROBLEMA
    300, // DEFINICIÓN
    300, // METODOLOGIAS
    350, // 5W1H
    400, // EJEMPLO 5W1H
    400, // EJEMPLO 2 5W1H
    400, // EJEMPLO 3 5W1H
    400, // ESPINA DE PESCADO
    300, // COMO HACER ESPINA DE PESCADO
    300, // EJEMPLO 1 ESPINA DE PESCADO
    300, // EJEMPLO 2 ESPINA DE PESCADO
    200, // ÁRBOL DE PROBLEMAS
    250, // COMO HACER EL ÁRBOL DE PROBLEMAS
    300, // EJEMPLO ÁRBOL DE PROBLEMAS
    300, // ESQUEMA DE REDACCIÓN
  ];
  int _currentseccion = 0;

  static int ID_BASE_PROGRESO = 6;

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
      drawer: const Menu(currentScreen: 'PlantiamientoProblema'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child:
                  esPantallaPequena
                      ? InteractiveViewer(
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
          '¿Sabes cómo crear un Planteamiento del Problema?',
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
      builder: (context, constraints) {
        bool esPantallaPequena = constraints.maxWidth < 1000;
        return Card(
          color: obtenercolor('Color_Fondo'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                textos[_index],
                                style: TextStyle(
                                  fontSize: tamanotexto(2),
                                  fontFamily: 'Calibri',
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
                          if (_index == 8 ||
                              _index == 9 ||
                              _index == 10 ||
                              _index == 12 ||
                              _index == 13 ||
                              _index == 14)
                            Spacer(),
                          if ( //_index == 8 ||
                          //_index == 9 ||
                          // _index == 10 ||
                          _index == 12 || _index == 13 || _index == 14)
                            Spacer(),
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
                    MaterialPageRoute(builder: (context) => const Titulo()),
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
                      //await guardarProgresoFinal(ID_BASE_PROGRESO);
                    }
                  });
                } else {
                  //await guardarProgresoFinal(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Justificacion(),
                    ),
                  );
                }
              },
              label: Text(
                _index < secciones.length - 1 ? 'Siguiente' : 'Adelante',
                style: TextStyle(
                  color: obtenercolor('Color_Texto_Principal'),
                  fontSize: tamanotexto(2),
                ),
              ),
              icon: Icon(
                Icons.arrow_forward,
                size: tamanotexto(2),
                color: obtenercolor('Color_Texto_Principal'),
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
    // se usa kIsweb para saber si estamos en un dispositivo web

    final ScrollController scrollController = ScrollController();

    return SizedBox(
      height: 190, // un poco más para dar espacio a la barra
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true, // <- importante para mostrar la barra
        trackVisibility: true,
        interactive: true, // <- habilita click & drag
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            final bool isVisited = pestanasVistas.contains(item['indice']);
            final bool isSelected = _tabController.index == item['indice'];

            return SizedBox(
              width: esPantallaGrande ? 190 : 140,
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
