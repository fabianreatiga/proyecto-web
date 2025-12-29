import 'package:url_launcher/url_launcher.dart';
// Paquete que permite abrir enlaces externos

import 'package:flutter/foundation.dart' show kIsWeb;
// Permite identificar si la aplicación se está ejecutando en la web

// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
// Se importa dart:html únicamente para abrir enlaces en la versión web

// Función que abre un enlace externo según la plataforma
Future<void> abrirLink(String url) async {
  // Se convierte el texto del enlace en un objeto Uri
  final Uri uri = Uri.parse(url);

  // Se valida si la aplicación se está ejecutando en la web
  if (kIsWeb) {
    try {
      // Abre el enlace en una nueva pestaña del navegador
      html.window.open(uri.toString(), '_blank');
    } catch (e) {
      // Muestra el error en consola si falla la apertura del enlace
      // ignore: avoid_print
      print('Error abriendo enlace: $e');
    }
  } else {
    // Android / iOS / Escritorio
    // Abre el enlace usando una aplicación externa del sistema
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      // Error en caso de que no se pueda abrir el enlace
      throw 'No se pudo abrir $url';
    }
  }
}
