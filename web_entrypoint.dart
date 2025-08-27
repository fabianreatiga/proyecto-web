/*import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:nuevomockups/main.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void main() async {
  setUrlStrategy(PathUrlStrategy());

  // ⚠️ En web probablemente esto falle si intentas conectar a Mongo Atlas
  // directamente, pero lo dejamos para que compile y puedas adaptarlo luego.
  final db = await mongo.Db.create(
    "mongodb+srv://<fabian>:<fabian3012>@cluster0.vwlmoje.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0",
  );
  await db.open();
  print("✅ Conectado a MongoDB Atlas (si el entorno lo permite)");

  runApp(
    MaterialApp(
      title: 'Investigación',
      debugShowCheckedModeBanner: false,
      home: Inicio(db: db),
    ),
  );
}*/
