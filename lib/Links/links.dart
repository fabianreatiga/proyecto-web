import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> abrirLink(String url) async {
  final Uri uri = Uri.parse(url);

  if (kIsWeb) {
    // ✅ Versión 100% funcional en compilaciones web
    try {
      html.window.open(uri.toString(), '_blank');
    } catch (e) {
      print('Error abriendo enlace: $e');
    }
  } else {
    // 📱 Android / iOS / Desktop
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }
}
