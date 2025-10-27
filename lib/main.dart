// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Titulo/titulo.dart';
import 'package:nuevomockups/global.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';

//obtenercolor, tamanotexto es una funcion global y se encuentra en el archivo color_texto.dart//

// Aquí defines SOLO una vez la URL base se debe de cambiar según la red local por el momento

/*const String baseApiUrl =
    "https://proyecto-api-1vjo.onrender.com"; //Eliminar comentario
*/
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized(); //en esta linea de codigo se asegura que los widgets esten inicializados antes de ejecutar la aplicacion

  runApp(
    MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Inicio(),
    ),
  );
} // en este bloque de código se esta iniciando la aplicación

class Inicio extends StatefulWidget {
  Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final TextEditingController _Nficha = TextEditingController();
  // variable donde se obtiene el texto del campo N° ficha
  final TextEditingController _NombrePrograma = TextEditingController();
  // variable donde se obtiene el texto del campo Nombre Programa
  final TextEditingController _NombreAprendiz = TextEditingController();
  // variable donde se obtiene el texto del campo Nombre Aprendiz

  bool _isLoading = false; // 🔥 Variable para controlar el icono de carga

  Future<bool> verificarConexion() async {
    var conectividad = await Connectivity().checkConnectivity();

    if (conectividad == ConnectivityResult.none) {
      return false; // No hay conexión
    }
    return true; // Hay conexión
  }

  /*  //quitar
  Future<bool> usuarioRegistrado(String nombre, String ficha) async {
    try {
      final response = await http.get(Uri.parse("$baseApiUrl/items"));
      if (response.statusCode == 200) {
        final List items = jsonDecode(response.body);
        // Retorna true si existe un item con ese nombre Y ficha
        return items.any(
          (item) => item['nombre'] == nombre && item['ficha'] == ficha,
        );
      }
    } catch (e) {
      print("⚠️ Error al verificar usuario: $e");
    }
    return false;
  } // en este blloque de código se verifica si el usuario ya está registrado

  // Función para guardar en API

  Future<void> _guardarEnAPI(BuildContext context) async {
    final data = {
      "nombre": _NombreAprendiz.text,
      "programa": _NombrePrograma.text,
      "ficha": _Nficha.text,
      //"progreso": 0,
      "fecha": DateTime.now().toIso8601String(),
    }; // en este bloque de código se crea un mapa con los datos que se van a enviar a la API

    await http.post(
      Uri.parse("$baseApiUrl/items"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
  } // en este bloque de código se envían los datos a la API y se maneja la respuesta

*/ //Quitar

  void _mostrarcamposenblanco(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            //title: Center(child: const Text('Error')),
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
  } // en este bloque de código se muestra un mensaje de error si hay campos en blanco

  void _mostrarSinConexion(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Sin conexión'),
            content: const Text(
              'No tienes conexión a Internet. Intenta nuevamente.',
            ),
            actions: [
              Center(
                child: Container(
                  width: 100,
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: obtenercolor('Color_Principal'),
                      foregroundColor: obtenercolor('Color_Texto_Principal'),
                    ),
                    child: const Text('Aceptar'),
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

    // 1️⃣ Verificar campos vacíos
    if (nombre.isEmpty || programa.isEmpty || ficha.isEmpty) {
      _mostrarcamposenblanco(context, 'No puede haber campos en blanco');
      return;
    }

    // 2️⃣ Verificar conexión antes de mostrar el ícono de carga
    bool conectado = await verificarConexion();
    if (!conectado) {
      _mostrarSinConexion(context);
      return;
    }

    // 3️⃣ Si todo está bien, mostrar el ícono de carga
    setState(() => _isLoading = true);

    try {
      setUsuarioGlobal(nombre);
      setFichaGlobal(ficha);
      setprogramaGlobal(programa);

      //  await guardarProgresoFinal(0);

      //  await usuarioRegistrado(nombre, ficha);
      //  await _guardarEnAPI(context);

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
      // 4️⃣ Siempre ocultar el ícono, incluso si ocurre un error
      setState(() => _isLoading = false);
    }
  }

  // en este bloque de código se verifica si el usuario ya está registrado, si no lo está se envían los datos a la API y se navega a la pantalla de Titulo

  @override
  Widget build(BuildContext context) {
    //este es el widget principal
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: obtenercolor('Color_Fondo'),
          //se usa obtenercolor para la funcion que tienen los colores ya definidos
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = constraints.maxWidth;
                      // aca se esta determinando el ancho de la pantallas
                      return Container(
                        child: Image.asset(
                          'assets/banner_superior.jpg',
                          //aca se carga la imagen del banner superior
                          width: screenWidth,
                          height:
                              screenWidth < 1000
                                  ? MediaQuery.of(context).size.height * 0.1
                                  : MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1300),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
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

        // 🔥 Overlay del icono de carga
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
    //este es el widget que es usa para cuando las pantallas pequeñas
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo_textura.png'),
          repeat: ImageRepeat.repeat,
          opacity: MediaQuery.of(context).size.width < 600 ? 0.3 : 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/logoSena.png',
              width: MediaQuery.of(context).size.width < 600 ? 100 : 150,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(35),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: aplicativo,
                    style: TextStyle(
                      fontSize: tamanotexto(3),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Calibri',
                    ),
                  ),
                  TextSpan(
                    text:
                        '\n\nCon este aplicativo busca Establecer estrategias y herramientas para el fomento de la investigación en'
                        ' el Sena permitirá al aprendiz, adquirir habilidades que se plasmen en resultados que brinden soluciones a las diferentes '
                        'problemáticas o necesidades que enfrenta la sociedad y los sectores productivos. De esta forma se tendrán egresados con mejores'
                        ' capacidades para investigar que aporten a la productividad y competitividad de la región y el país. Por tanto, este proyecto'
                        ' busca desarrollar un software interactivo que facilite el aprendizaje en la estructuración de proyectos de investigación y'
                        ' está dirigido a aprendices en programas tecnológicos, técnicos y operarios, además de instructores interesados en mejorar'
                        ' sus conocimientos en la temática de investigación. Igualmente, la herramienta se implementará en semilleros y el grupo de'
                        ' investigación del centro de formación. Se proyecta que esta herramienta estimule el aprendizaje hacia la investigación al'
                        ' hacer uso de las TIC y de una plataforma interactiva que incentive el pensamiento crítico y la creatividad.',
                    style: TextStyle(
                      fontSize: tamanotexto(2),
                      height: 1.4,
                      fontFamily: 'Calibri',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          _campoTexto(
            label: 'Nombre',
            icon: Icons.person,
            hint: 'Escribe tu nombre',
            controller: _NombreAprendiz,
          ),
          const SizedBox(height: 15),
          _campoTexto(
            label: 'Nombre Programa',
            icon: Icons.text_decrease,
            hint: 'Nombre Programa',
            controller: _NombrePrograma,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 250,
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
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(7),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _botonIniciar(context),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildRowLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(35),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: aplicativo,
                            style: TextStyle(
                              fontSize: tamanotexto(3),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Calibri',
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\nCon este aplicativo busca Establecer estrategias y herramientas para el fomento de la investigación en'
                                ' el Sena permitirá al aprendiz, adquirir habilidades que se plasmen en resultados que brinden soluciones a las diferentes '
                                'problemáticas o necesidades que enfrenta la sociedad y los sectores productivos. De esta forma se tendrán egresados con mejores'
                                ' capacidades para investigar que aporten a la productividad y competitividad de la región y el país. Por tanto, este proyecto'
                                ' busca desarrollar un software interactivo que facilite el aprendizaje en la estructuración de proyectos de investigación y'
                                ' está dirigido a aprendices en programas tecnológicos, técnicos y operarios, además de instructores interesados en mejorar'
                                ' sus conocimientos en la temática de investigación. Igualmente, la herramienta se implementará en semilleros y el grupo de'
                                ' investigación del centro de formación. Se proyecta que esta herramienta estimule el aprendizaje hacia la investigación al'
                                ' hacer uso de las TIC y de una plataforma interactiva que incentive el pensamiento crítico y la creatividad.',
                            style: TextStyle(
                              fontSize: tamanotexto(2),
                              height: 1.4,
                              fontFamily: 'Calibri',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                  label: 'Nombre',
                  icon: Icons.person,
                  hint: 'Escribe tu nombre',
                  controller: _NombreAprendiz,
                ),
                const SizedBox(height: 15),
                _campoTexto(
                  label: 'Nombre Programa',
                  icon: Icons.text_decrease,
                  hint: 'Nombre Programa',
                  controller: _NombrePrograma,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _Nficha,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: obtenercolor('Color_Fondo'),
                      labelText: 'N° Ficha',
                      hintText: 'Escribe tu N° ficha',
                      labelStyle: TextStyle(color: Colors.black),
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(7),
                    ],
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
        onPressed:
            _isLoading ? null : () => _boton(context), // 🔥 Evita doble clic
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
    required String label,
    required IconData icon,
    required String hint,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller,
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
} // en esta linea de codigo le damos etilo a los campos de texto

const String aplicativo =
    'Aplicativo para la estructuración de proyectos de investigación';
