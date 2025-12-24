import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuevomockups/Appbar/appbar.dart';
import 'package:nuevomockups/Bibliografia/bibliografia.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Encuesta/encuesta.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Menus/menus.dart';
import 'package:nuevomockups/global.dart';

// Solo se usa en web

class Busqueda extends StatelessWidget {
  const Busqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Busquedas();
  }
}

class Busquedas extends StatefulWidget {
  const Busquedas({super.key});

  @override
  State<Busquedas> createState() => _BusquedasState();
}

class _BusquedasState extends State<Busquedas> with TickerProviderStateMixin {
  // ID único del subtema

  int _index = 0; //indica que las secciones inicia en la primera
  late TabController
      _tabController; //se usa un TabController para controlar las pestañas
  final List<int> pestanasVistas =
      []; // en esta variable se guarda las pestañas ya vistas

  final List<String> textos = [
    'El objetivo de una búsqueda es obtener información relevante, verídica y útil que permita dar respuesta a una pregunta, resolver un problema o profundizar en un tema específico. Mediante este proceso, se pretende reunir y analizar datos, ideas o evidencias que ayuden a comprender mejor una situación y a tomar decisiones fundamentadas.'
        'Además, la búsqueda tiene como propósito fomentar el pensamiento crítico y el aprendizaje autónomo, ya que impulsa a comparar diferentes fuentes, identificar la más confiable y seleccionar la información que mejor se adapte al propósito planteado.'
        'En contextos académicos, profesionales o personales, la búsqueda permite ampliar el conocimiento, generar nuevas ideas y fortalecer la capacidad de análisis, convirtiéndose en una herramienta esencial para el desarrollo intelectual y la solución de problemas.',
    'Utilizar palabras clave y operadores lógicos permite obtener resultados más precisos y relevantes al buscar en Google. '
        'Los operadores más comunes son:\n'
        '• AND (Y): incluye todos los términos. \n'
        '• OR (O): busca cualquiera de los términos.\n'
        '• NOT (-): excluye palabras no deseadas.\n'
        '• Comillas (“ ”): buscan una frase exacta.\n'
        '• Asterisco (*): reemplaza una palabra desconocida.\n'
        '• site: limita la búsqueda a un sitio web específico.\n'
        'En conjunto, estos operadores ayudan a filtrar y combinar términos para encontrar información confiable, facilitando una búsqueda más profesional y eficiente para trabajos académicos o investigaciones.',
    'Google Scholar, también llamado Google Académico, es una herramienta gratuita de Google que permite buscar información científica y académica de manera sencilla. Está diseñada para encontrar artículos, libros, tesis, resúmenes, informes y publicaciones de revistas especializadas en diferentes áreas del conocimiento.'
        'A diferencia del buscador común, Google Scholar se enfoca únicamente en fuentes confiables y de carácter académico, lo que garantiza resultados más precisos y útiles para la investigación, el estudio o el trabajo universitario.'
        'Además, muestra cuántas veces ha sido citado un documento, quién lo ha citado y en qué otros trabajos se ha utilizado, lo cual ayuda a evaluar la relevancia y credibilidad de las fuentes.'
        'En resumen, Google Scholar es una plataforma de búsqueda académica que facilita el acceso a información verificada, actualizada y proveniente de instituciones educativas, científicas y profesionales.',
    '',
    'Google Tendencias (Google Trends) es una herramienta gratuita de Google que permite analizar qué temas o palabras son más buscados en Internet. Muestra cómo cambia el interés por un término a lo largo del tiempo y en diferentes regiones, además de permitir comparar varios temas o categorías como educación, salud o tecnología.'
        'También ayuda a identificar tendencias, estudiar patrones de búsqueda y conocer los intereses actuales de las personas. Es especialmente útil para estudiantes, investigadores y profesionales que necesitan información confiable sobre lo que la gente busca en la web.',
    'Una base de datos científica es una plataforma digital que almacena, organiza y permite acceder a información validada de investigaciones, como artículos, tesis y revistas especializadas. Facilita la búsqueda, consulta y citación de fuentes confiables, garantizando la calidad y veracidad del conocimiento científico.',
    'Una base de datos científica sirve para:\n'
        '🔍 Buscar información confiable: Permite encontrar artículos, investigaciones y documentos revisados por expertos.\n'
        '🧠 Consultar antecedentes y estado del arte: Ayuda a conocer lo que ya se ha investigado sobre un tema.\n'
        '📝 Citar correctamente: Facilita la obtención de datos bibliográficos para evitar el plagio.\n'
        '📊 Analizar tendencias científicas: Permite ver qué temas son más estudiados o citados.\n'
        '🎓 Apoyar trabajos académicos y tesis: Brinda información actualizada y verificada para sustentar investigaciones.',
    'El SENA ofrece una Biblioteca Virtual donde todos los aprendices e instructores pueden acceder a bases de datos académicas y científicas. Estas bases contienen libros digitales, revistas, artículos, normas técnicas, investigaciones y otros recursos confiables para apoyar la formación y los proyectos. ',
  ]; // lista de los textos que se van a mostrar

  final List<String> imagenes = [
    'assets/Busqueda/Busqueda_Objetivos.png', // OBJETIVO
    'assets/Busqueda/Busqueda_Operadores_Booleanos.jpg', // BUSQUEDA EN GOOGLE CON OPERADORES LOGICOS Y PALABRAS CLAVE
    'assets/Busqueda/Busqueda_Google_Academico.png', // GOOGLE ACADÉMICO (SCHOLAR)
    'assets/Busqueda/Busqueda_Google_Alertas.png', // ALERTAS DE GOOGLE
    'assets/Busqueda/Busqueda_Google_Tendencias.png', // GOOGLE TENDENCIAS (TRENDS)
    'assets/BasesDatos/Bases_De_Datos_Definicion.png', //DEFINICIÓN
    'assets/BasesDatos/Bases_De_Datos_Que_Es.png', //¿PARA QUE SIRVE?
    'assets/BasesDatos/Bases_De_Datos_Biblioteca_Sena.jpg', //¿DÓNDE PUEDES ENCONTRAR LAS BASES DE DATOS CIENTÍFICAS?
  ]; // lista de las imagenes

  // ignore: unused_field
  int _currentseccion = 0;

  final List<String> secciones = [
    'OBJETIVO',
    'BUSQUEDA EN GOOGLE CON OPERADORES LOGICOS Y PALABRAS CLAVE',
    'GOOGLE ACADÉMICO (SCHOLAR)',
    'ALERTAS DE GOOGLE',
    'GOOGLE TENDENCIAS (TRENDS)',
    'DEFINICIÓN',
    '¿PARA QUE SIRVE?',
    '¿DÓNDE PUEDES ENCONTRAR LAS BASES DE DATOS CIENTÍFICAS?', // lista de las secciones
  ]; // lista de las secciones

  List<double> grande(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.2 - 18, // OBJETIVO
      MediaQuery.of(context).size.width * 0.18 -
          18, // BUSQUEDA EN GOOGLE CON OPERADORES LOGICOS Y PALABRAS CLAVE
      MediaQuery.of(context).size.width * 0.25 -
          18, // GOOGLE ACADÉMICO (SCHOLAR)
      MediaQuery.of(context).size.width * 0.18 - 18, // ALERTAS DE GOOGLE
      MediaQuery.of(context).size.width * 0.2 -
          18, // GOOGLE TENDENCIAS (TRENDS)
      250, // DEFINICIÓN
      250, // ¿PARA QUE SIRVE?
      130, // ¿DÓNDE PUEDES ENCONTRAR LAS BASES DE DATOS CIENTÍFICAS?
    ];
  } // lista de las alturas de las imagenes para pantallas grandes

  List<double> pequena(BuildContext context) {
    return [
      MediaQuery.of(context).size.width * 0.3 - 18, //OBJETIVO
      MediaQuery.of(context).size.width * 0.3 -
          18, // BUSQUEDA EN GOOGLE CON OPERADORES LOGICOS Y PALABRAS CLAVE
      MediaQuery.of(context).size.width * 0.4 -
          18, // GOOGLE ACADÉMICO (SCHOLAR)
      MediaQuery.of(context).size.width * 0.3 - 18, // ALERTAS DE GOOGLE
      MediaQuery.of(context).size.width * 0.4 -
          18, // GOOGLE TENDENCIAS (TRENDS)
      250, // DEFINICIÓN
      250, // ¿PARA QUE SIRVE?
      130, // ¿DÓNDE PUEDES ENCONTRAR LAS BASES DE DATOS CIENTÍFICAS?
    ];
  } // lista de las alturas de las imagenes para pantallas pequenas

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
    final bool esPantallaPequena =
        MediaQuery.of(context).size.shortestSide < 650;

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
      drawer: Menu(
        currentScreen: 'Busqueda',
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
                'assets/Busqueda/Fondo_superior_Derecha.png',
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
                'assets/Icono_Microscopio.png',
                width: esPantallaPequena ? 45 : 80,
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
                'assets/Busqueda/Fondo_Supeior_Izquierda.png',
                width: esPantallaPequena ? 120 : 220,
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
                'assets/Busqueda/Fondo_inferior_Izquierda.png',
                width: esPantallaPequena ? 120 : 220,
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
                'assets/Busqueda/Fondo_Inferior_Derecha.png',
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
                'assets/Icono_Planeta.png',
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
                      child: esPantallaPequena
                          ? InteractiveViewer(
                              // 🔍 Zoom solo en pantallas pequeñas
                              constrained: true,
                              minScale: 1.0,
                              maxScale: 5.0,
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
                                  SizedBox(height: altura(1)),
                                ],
                              ),
                            )
                          : Column(
                              // 💻 En pantallas grandes sin zoom
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
                                const SizedBox(height: 50),
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

    final alturaImagenPequena = pequena(context);
    final alturaImagengrande = grande(context);

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
                  SelectableText(
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
                            if (_index == 3)
                              SelectableText.rich(
                                TextSpan(
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
                                        //decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          abrirLink(
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
                                textAlign: TextAlign.justify,
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
                                        //decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          abrirLink(
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
                                        //decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          abrirLink(
                                            'https://scholar.google.com',
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            if (_index == 7)
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
                                      text: 'Para acceder:\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: obtenercolor(
                                          'Color_Principal',
                                        ),
                                        fontSize: tamanotexto(1) - 10,
                                      ),
                                    ),
                                    TextSpan(text: 'Ingresa a 👉'),
                                    TextSpan(
                                      text:
                                          ' https://biblioteca.sena.edu.co/paginas/bases.html\n',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        //decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          abrirLink(
                                            'https://biblioteca.sena.edu.co/paginas/bases.html',
                                          );
                                        },
                                    ),
                                    TextSpan(
                                      text: 'Allí verás dos tipos:.\n',
                                    ),
                                    TextSpan(
                                      text: 'Bases suscritas: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'el SENA paga la licencia y puedes entrar con usuario institucional.\n',
                                    ),
                                    TextSpan(
                                      text: 'Bases libres: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'disponibles para todos sin registro.',
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
                                                //decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  abrirLink(
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
                                    if (_index == 7)
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
                                              text: 'Para acceder:\n',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: obtenercolor(
                                                  'Color_Principal',
                                                ),
                                                fontSize: tamanotexto(1) - 10,
                                              ),
                                            ),
                                            TextSpan(text: 'Ingresa a 👉'),
                                            TextSpan(
                                              text:
                                                  ' https://biblioteca.sena.edu.co/paginas/bases.html\n',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                //decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  abrirLink(
                                                    'https://biblioteca.sena.edu.co/paginas/bases.html',
                                                  );
                                                },
                                            ),
                                            TextSpan(
                                              text: 'Allí verás dos tipos:.\n',
                                            ),
                                            TextSpan(
                                              text: 'Bases suscritas: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'el SENA paga la licencia y puedes entrar con usuario institucional.\n',
                                            ),
                                            TextSpan(
                                              text: 'Bases libres: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'disponibles para todos sin registro.',
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
                                              text:
                                                  'Puedes acceder a la herramienta aquí: ',
                                            ),
                                            TextSpan(
                                              text: 'https://trends.google.com',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                //decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  abrirLink(
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
                                              text:
                                                  'https://scholar.google.com',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                //decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  abrirLink(
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
                  if (_index == 2)
                    Center(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Column(
                            children: [
                              /*Text(
                                'Ejemplo',
                                style: TextStyle(
                                  fontSize: tamanotexto(1),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                  color: obtenercolor('Color_Principal'),
                                  backgroundColor: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),*/
                              SizedBox(height: 20),
                              Image.asset(
                                'assets/Busqueda/Busqueda_Ejemplo_Google_Academico1.png',
                              ),
                              Image.asset(
                                'assets/Busqueda/Busqueda_Ejemplo_Google_Academico2.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (_index == 3)
                    Center(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/Busqueda/Busqueda_Ejemplo_Google_Alertas1.png',
                              ),
                              Image.asset(
                                'assets/Busqueda/Busqueda_Ejemplo_Google_Alertas2.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (_index == 4)
                    Center(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Busqueda/Busqueda_Ejemplo_Google_Tendencias1.png',
                            ),
                            Image.asset(
                              'assets/Busqueda/Busqueda_Ejemplo_Google_Tendencias2.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_index == 7)
                    Center(
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Image.asset('assets/BasesDatos/Ejemplo1.png'),
                            SizedBox(height: 10),
                            Image.asset('assets/BasesDatos/Ejemplo2.png'),
                            SizedBox(height: 10),
                            Image.asset('assets/BasesDatos/Ejemplo3.png'),
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
                    MaterialPageRoute(builder: (context) => Bibliografia()),
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

                  setState(() {
                    _currentseccion = _index + 1;
                  });

                  int idReal = ID_BASE_PROGRESO + _index + 1;

                  if (!ProgresoGlobal.pestanasVistas.contains(idReal)) {
                    ProgresoGlobal.pestanasVistas.add(idReal);
                    await ProgresoGlobal.guardarLocal();

                    // ignore: avoid_print
                    print(" Progreso sumado → ID: $idReal");

                    await guardarProgresoEnAPI(idReal);
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Encuesta()),
                  );
                  ProgresoGlobal.marcarVisto(2);
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
                          color: (isSelected || isVisited)
                              ? obtenercolor(
                                  'Color_Principal',
                                  // ignore: deprecated_member_use
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
    {
      'id': 7,
      'text': 'Definición',
      'icon': Icons.info,
      'color': obtenercolor('Color_Secundario'),
      'indice': 5,
    },
    {
      'id': 8,
      'text': '¿Para qué sirve?',
      'icon': Icons.question_mark,
      'color': obtenercolor('Color_Secundario'),
      'indice': 6,
    },
    {
      'id': 9,
      'text': 'Biblioteca SENA',
      'icon': Icons.storage,
      'color': obtenercolor('Color_Secundario'),
      'indice': 7,
    },
  ];
}
