import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

Future<void> abrirLink(String url) async {
  final Uri uri = Uri.parse(url);

  if (kIsWeb) {
    try {
      html.window.open(uri.toString(), '_blank');
    } catch (e) {
      // ignore: avoid_print
      print('Error abriendo enlace: $e');
    }
  } else {
    // 📱 Android / iOS / Desktop
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }
}
