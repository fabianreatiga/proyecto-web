// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuevomockups/Color_texto/color_texto.dart';
import 'package:nuevomockups/Titulo/titulo.dart';
import 'package:nuevomockups/global.dart';
import 'package:http/http.dart' as http;

//obtenercolor, tamanotexto es una funcion global y se encuentra en el archivo color_texto.dart//

// Aquí defines SOLO una vez la URL base se debe de cambiar según la red local por el momento

const String baseApiUrl = "http://192.168.0.101:5000";
//const String baseApiUrl = "http://192.168.101.19:5000";

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

class Inicio extends StatelessWidget {
  Inicio({super.key});

  final TextEditingController _Nficha = TextEditingController();
  // variable donde se obtiene el texto del campo N° ficha
  final TextEditingController _NombrePrograma = TextEditingController();
  // variable donde se obtiene el texto del campo Nombre Programa
  final TextEditingController _NombreAprendiz = TextEditingController();
  // variable donde se obtiene el texto del campo Nombre Aprendiz

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
      "progreso": 0,
      "fecha": DateTime.now().toIso8601String(),
    }; // en este bloque de código se crea un mapa con los datos que se van a enviar a la API

    await http.post(
      Uri.parse("$baseApiUrl/items"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
  } // en este bloque de código se envían los datos a la API y se maneja la respuesta

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

  void _boton(BuildContext context) async {
    final nombre = _NombreAprendiz.text.trim();
    final programa = _NombrePrograma.text.trim();
    final ficha = _Nficha.text.trim();

    if (nombre.isEmpty || programa.isEmpty || ficha.isEmpty) {
      _mostrarcamposenblanco(context, 'No puede haber campos en blanco');
      return;
    } // aca se verifica si hay campos en blanco y si los hay mustra un mensaje de error

    setUsuarioGlobal(nombre); // aca guardamos el nombre en la variable global
    setFichaGlobal(ficha); // aca guardamos la ficha en la variable global

    await usuarioRegistrado(
      nombre,
      ficha,
    ); //aca se verifica si el usuario ya está registrado
    await _guardarEnAPI(context); // aca se envian los datos a la API

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Titulo()),
    ); // aca se navega a la pantalla de Titulo

    _NombreAprendiz.clear();
    _NombrePrograma.clear();
    _Nficha.clear();
    // Limpia los campos después de navegar
  }
  // en este bloque de código se verifica si el usuario ya está registrado, si no lo está se envían los datos a la API y se navega a la pantalla de Titulo

  @override
  Widget build(BuildContext context) {
    //este es el widget principal
    return Scaffold(
      backgroundColor: obtenercolor('Color_Fondo'),
      //se usa obtenercolor para la funcion que tienen los colores ya definidos
      body: Center(
        child: SingleChildScrollView(
          //se esta usando singlechildscrollview para activar la función de scroll para no tener problemas con desbordamientos en pantallas pequeñas
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
                          screenWidth < 600
                              ? MediaQuery.of(context).size.height * 0.1
                              : MediaQuery.of(context).size.height * 0.3,
                      // se esta usando el operador ternario para determinar la altura del banner
                      // si el ancho de la pantalla es menor a 600, la altura será 150 de lo contrario será 200
                      fit: BoxFit.cover,
                      // se usa BoxFit.cover para que la imagen se ajuste al tamaño de la pantalla
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1300),
                  // se usa BoxConstraints para limitar el ancho de la pantalla  del conteido
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isSmallScreen = constraints.maxWidth < 1000;
                        return isSmallScreen
                            ? _buildColumnLayout(context)
                            : _buildRowLayout(context);
                        //estamos usando el operador ternario y isSmallScreen, si la pantalla es menor a 1000 se modifica
                        // si es menor a 1000 llama al widget _buildColumnLayout y de lo contrario llama al widget _buildRowLayout
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnLayout(BuildContext context) {
    //este es el widget que es usa para cuando las pantallas
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo_textura.png'),
          //aca cargamas la imagen con la textura de fondo
          repeat: ImageRepeat.repeat, // 🔥 Se repite en todo el fondo
          opacity: MediaQuery.of(context).size.width < 600 ? 0.3 : 0.2,
        ),
      ),
      //usamos un boxdecoration para decorar el contenedor con color, con borde, en este caso es con una imagen
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
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(35),
            child: Text.rich(
              TextSpan(
                //se esta usando textspan para dar formato a diferentes partes del texto
                children: [
                  TextSpan(
                    text: aplicativo,
                    // aplicativo es una variable que contiene un texto
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
                      //se esta usando tamanotexto para determinar el tamaño del texto mediante una función
                      height: 1.4,
                      fontFamily: 'Calibri',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              //se esta usando textalign para centrar el texto en el contenedor
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
          const SizedBox(height: 30),
          _botonIniciar(context),
        ],
      ),
    );
  }

  Widget _buildRowLayout(BuildContext context) {
    // este es el widget que se usa para cuando las pantallas son grandes
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
                  // se agrego este SizedBox para integrar el campo de texto del N° ficha
                  width: 250,
                  child: TextField(
                    controller: _Nficha,
                    decoration: InputDecoration(
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
