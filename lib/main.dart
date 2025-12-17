// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Links/links.dart';
import 'package:nuevomockups/Titulo/titulo.dart';
import 'package:nuevomockups/global.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';

const String baseApiUrl = "https://proyecto-web-4xe1.onrender.com";

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Inicio(),
    ),
  );
}
//noooo no sirve

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int index = 0;

  List<String> imagenes = [
    'assets/Resumen/1.png',
    'assets/Resumen/2.png',
    'assets/Resumen/3.png',
    'assets/Resumen/4.png',
    'assets/Resumen/5.png',
    'assets/Resumen/6.png',
    'assets/Resumen/7.png',
    'assets/Resumen/8.png',
    'assets/Resumen/9.png',
    'assets/Resumen/10.png',
    'assets/Resumen/11.png',
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (!mounted) return;
      setState(() {
        index = (index + 1) % imagenes.length;
      });
    });
  }

  final TextEditingController _Nficha = TextEditingController();
  final TextEditingController _NombrePrograma = TextEditingController();
  final TextEditingController _NombreAprendiz = TextEditingController();

  bool _isLoading = false;

  Future<bool> verificarConexion() async {
    var conectividad = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return conectividad != ConnectivityResult.none;
  }

  Future<bool> usuarioRegistrado(String nombre, String ficha) async {
    try {
      final response = await http.get(Uri.parse("$baseApiUrl/items"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List items = decoded['items'] ?? [];
        return items.any(
          (item) => item['nombre'] == nombre && item['ficha'] == ficha,
        );
      }
    } catch (e) {
      print("⚠️ Error al verificar usuario: $e");
    }
    return false;
  }

  Future<void> _guardarEnAPI(BuildContext context) async {
    final data = {
      "nombre": _NombreAprendiz.text,
      "programa": _NombrePrograma.text,
      "ficha": _Nficha.text,
      "fecha": DateTime.now().toIso8601String(),
    };

    try {
      final response = await http.post(
        Uri.parse("$baseApiUrl/items"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        print("Error al guardar en API: ${response.body}");
      }
    } catch (e) {
      print("Error HTTP: $e");
    }
  }

  Future<void> guardarProgresoFinal(int incremento) async {
    try {
      final data = {"nombre": _NombreAprendiz.text, "ficha": _Nficha.text};

      final response = await http.post(
        Uri.parse("$baseApiUrl/guardarProgreso"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print("Progreso actualizado: ${json['progreso']}");
      } else {
        print("Error al guardar progreso: ${response.body}");
      }
    } catch (e) {
      print("Error al procesar datos: $e");
    }
  }

  void _mostrarcamposenblanco(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(mensaje),
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.all(0),
              width: 100,
              child: TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: obtenercolor('Color_Principal'),
                  foregroundColor: obtenercolor('Color_Texto_Principal'),
                ),
                child: Text('Aceptar'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _boton(BuildContext context) async {
    final nombre = _NombreAprendiz.text.trim();
    final programa = _NombrePrograma.text.trim();
    final ficha = _Nficha.text.trim();

    if (nombre.isEmpty || programa.isEmpty || ficha.isEmpty) {
      _mostrarcamposenblanco(context, 'No puede haber campos en blanco');
      return;
    }

    setState(() => _isLoading = true);

    try {
      setUsuarioGlobal(nombre);
      setFichaGlobal(ficha);
      setprogramaGlobal(programa);

      // ❌ ESTA LÍNEA NO ➝ await guardarProgresoFinal(0);

      await usuarioRegistrado(nombre, ficha);
      await _guardarEnAPI(context);

      await sincronizarProgresoConAPI();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Titulo()),
      );

      _NombreAprendiz.clear();
      _NombrePrograma.clear();
      _Nficha.clear();
    } catch (e) {
      print("⚠️ Error al procesar datos: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: obtenercolor('Color_Fondo'),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = constraints.maxWidth;
                      return Column(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/banner_superior.jpg',
                              width: screenWidth,
                              height: screenWidth < 1000
                                  ? MediaQuery.of(context).size.height * 0.1
                                  : MediaQuery.of(context).size.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1500),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            bool isSmallScreen = constraints.maxWidth < 1000;
                            return isSmallScreen
                                ? _buildColumnLayout(context)
                                : _buildRowLayout(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildColumnLayout(BuildContext context) {
    //este es el widget que es usa para cuando las pantallas son pequeñas
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo_textura.png'),
          //aca cargamas la imagen con la textura de fondo
          repeat: ImageRepeat.repeat, // Se repite en todo el fondo
          opacity: MediaQuery.of(context).size.width < 600 ? 0.3 : 0.2,
        ),
      ),
      //usamos un boxdecoration para decorar el contenedor con color, con borde, en este caso es con una imagen
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/logoSena.png',
                //aca cargamos la imagen del logo del sena
                width: MediaQuery.of(context).size.width < 600 ? 100 : 150,
                //con este operador ternario se determina el tamaño del logo dependiendo del tamaño de la pantalla
                fit: BoxFit.contain,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                // double screenWidth = constraints.maxWidth;
                return Column(
                  children: [
                    InkWell(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Ver video',
                              style: TextStyle(
                                color: obtenercolor('Color_Principal'),
                                fontSize: tamanotexto(1) - 15,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(
                              imagenes[index],
                              width: 350,
                              height: 197,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => {abrirLink('https://youtu.be/y7czaORl13Y')},
                    ),
                    /* Container(
                            child: Image.asset(
                              imagenes[index],
                              //width: screenWidth,
                              height:
                                  screenWidth < 1000
                                      ? MediaQuery.of(context).size.height * 0.1
                                      : MediaQuery.of(context).size.height *
                                          0.3,
                              fit: BoxFit.cover,
                            ),
                          ),*/
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aplicativo,
                    style: TextStyle(
                      fontSize: tamanotexto(3),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Calibri',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    descripciones,
                    style: TextStyle(
                      fontSize: tamanotexto(2) - 6,
                      height: 1.4,
                      fontFamily: 'Calibri',
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _campoTexto(
              label: 'Nombres y Apellidos',
              icon: Icons.person,
              hint: 'Escribe tus nombres y apellidos',
              controller: _NombreAprendiz,
            ),
            const SizedBox(height: 15),
            Tooltip(
              message: 'Si eres intructor, colocar "Instructor"',
              child: _campoTexto(
                label: 'Nombre Programa',
                icon: Icons.text_decrease,
                hint: 'Nombre Programa',
                controller: _NombrePrograma,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: Tooltip(
                message: 'Si eres intructor,colocar "0000000" ',
                // se agrego este SizedBox para integrar el campo de texto del N° ficha
                child: TextField(
                  controller: _Nficha,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: obtenercolor('Color_Fondo'),
                    labelText: 'N° Ficha',
                    hintText: 'Escribe tu N° ficha',
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: obtenercolor('Color_Principal'),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: obtenercolor('Color_Principal'),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number, // Abre teclado numérico
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Solo dígitos
                    LengthLimitingTextInputFormatter(7),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _botonIniciar(context),
          ],
        ),
      ),
    );
  }

  int obtenerFlex(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 1200) {
      return 3; // celulares pequeños
    } else if (width > 1200) {
      return 4; // tablets o pantallas medianas
    } else {
      return 3; // pantallas grandes o PC
    }
  }

  Widget _buildRowLayout(BuildContext context) {
    // este es el widget que se usa para cuando las pantallas son grandes
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: obtenerFlex(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  Positioned.fill(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/fondo_textura.png'),
                                repeat: ImageRepeat.repeatY,
                                opacity: 0.3,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/fondo_textura.png'),
                                repeat: ImageRepeat.repeatY,
                                opacity: 0.3,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/fondo_textura.png'),
                                repeat: ImageRepeat.repeatY,
                                opacity: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // double screenWidth = constraints.maxWidth;
                          return Column(
                            children: [
                              InkWell(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ver video',
                                        style: TextStyle(
                                          color: obtenercolor(
                                            'Color_Principal',
                                          ),
                                          fontSize: tamanotexto(1) - 15,
                                          fontFamily: 'Calibri',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Image.asset(
                                        imagenes[index],
                                        width: 400,
                                        height: 247,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => {
                                  abrirLink('https://youtu.be/y7czaORl13Y'),
                                },
                              ),
                              /* Container(
                            child: Image.asset(
                              imagenes[index],
                              //width: screenWidth,
                              height:
                                  screenWidth < 1000
                                      ? MediaQuery.of(context).size.height * 0.1
                                      : MediaQuery.of(context).size.height *
                                          0.3,
                              fit: BoxFit.cover,
                            ),
                          ),*/
                            ],
                          );
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                aplicativo,
                                style: TextStyle(
                                  fontSize: tamanotexto(3),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Calibri',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Text(
                                descripciones,
                                style: TextStyle(
                                  fontSize: tamanotexto(
                                      6), // en el tamaño del texto se essta usando 6 para obtener el tamaño de texto ma pequeño
                                  height: 1.4,
                                  fontFamily: 'Calibri',
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/fondo_textura.png'),
                fit: BoxFit.cover,
                opacity: 0.30,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                //usamos boxshadow para darle sombra al contenedor
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/logoSena.png',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                _campoTexto(
                  label: 'Nombres y Apellidos',
                  icon: Icons.person,
                  hint: 'Escribe tus nombres y apellidos',
                  controller: _NombreAprendiz,
                ),
                const SizedBox(height: 15),
                Tooltip(
                  message: 'Si eres intructor, colocar "Instructor"',
                  child: _campoTexto(
                    label: 'Nombre Programa',
                    icon: Icons.text_decrease,
                    hint: 'Nombre Programa',
                    controller: _NombrePrograma,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  child: Tooltip(
                    message: 'Si eres intructor, colocar "0" ',
                    // se agrego este SizedBox para integrar el campo de texto del N° ficha
                    //ejemplo
                    child: TextField(
                      controller: _Nficha,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: obtenercolor('Color_Fondo'),
                        labelText: 'N° Ficha',
                        hintText: 'Escribe tu N° ficha',
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: obtenercolor('Color_Principal'),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: obtenercolor('Color_Principal'),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType:
                          TextInputType.number, // Abre teclado numérico
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Solo dígitos
                        LengthLimitingTextInputFormatter(7),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _botonIniciar(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _botonIniciar(BuildContext context) {
    //se creo este widget para derle estilo al boton de iniciar
    return SizedBox(
      width: 180,
      height: 45,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: obtenercolor('Color_Principal'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        onPressed: () {
          _boton(context);
        },
        icon: Icon(
          Icons.arrow_forward,
          color: obtenercolor('Color_Texto_Principal'),
          size: tamanotexto(3),
        ),
        label: Text(
          'INICIAR',
          style: TextStyle(
            fontSize: tamanotexto(2),
            color: obtenercolor('Color_Texto_Principal'),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget _campoTexto({
    //se creo este widget para darle estilo a los campos de texto
    required String label,
    required IconData icon,
    required String hint,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller, // <-- agregado
        decoration: InputDecoration(
          filled: true,
          fillColor: obtenercolor('Color_Fondo'),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          hintText: hint,
          prefixIcon: Icon(icon, color: obtenercolor('Color_Principal')),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: obtenercolor('Color_Principal'),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

const String aplicativo =
    'Aplicativo para la estructuración de proyectos de investigación';
//se esta usando esta variable para guardar un texto, se esta uasndo en 2 partes del codigo

const String descripciones =
    'Con este aplicativo busca establecer estrategias y herramientas para el fomento de la investigación en el Sena permitirá al aprendiz, adquirir habilidades que se plasmen en resultados que brinden soluciones a las diferentes problemáticas o necesidades que enfrenta la sociedad y los sectores productivos. '
    'De esta forma se tendrán egresados con mejores capacidades para investigar que aporten a la productividad y competitividad de la región y el país. '
    'Por tanto, este proyecto busca desarrollar un software interactivo que facilite el aprendizaje en la estructuración de proyectos de investigación y está dirigido a aprendices en programas tecnológicos, técnicos y operarios, además de instructores interesados en mejorar sus conocimientos en la temática de investigación. '
    'Igualmente, la herramienta se implementará en semilleros y el grupo de investigación del centro de formación. '
    'Se proyecta que esta herramienta estimule el aprendizaje hacia la investigación al hacer uso de las TIC y de una plataforma interactiva que incentive el pensamiento crítico y la creatividad.';
