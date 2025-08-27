import 'package:flutter/material.dart';

Color obtenercolor(String color) {
  switch (color) {
    case 'Color_Principal': //color principal para el uso de botones y appbars
      return const Color.fromRGBO(57, 169, 0, 1);
    case 'Color_Secundario': // Color secundario para el uso de botones y appbars
      return const Color.fromRGBO(255, 137, 0, 1);
    case 'Color_Texto_Principal': // Color de texto y de iconos
      return Colors.white;
    case 'Color_Fondo': // Color del fondo de las pantallas
      return Colors.white;
    default:
      return Colors.white;
  }
}

double tamanotexto(int valor) {
  switch (valor) {
    case 1: //Tamaño de texto para titulos
      return 40;
    case 2: //Tamaño para texto normal
      return 18;
    case 3: // Tamaño para subtitulos
      return 28;
    default:
      return 18;
  }
}
