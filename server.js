const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// ================================
// CONFIGURACIÓN INICIAL
// ================================
console.log("VALOR REAL DE MONGO_URI ===>");
console.log(process.env.MONGO_URI);

app.use(cors());
app.use(express.json());

// ================================
// CONEXIÓN ÚNICA A MONGODB
// ================================
let mongoReady = false;

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
  .then(() => {
    console.log("✅ Conectado a MongoDB");
    mongoReady = true;
  })
  .catch(err => console.error("❌ Error conectando a MongoDB:", err));

// Middleware para evitar requests mientras MongoDB inicia
app.use((req, res, next) => {
  if (!mongoReady) {
    return res.status(503).json({
      mensaje: "Servidor iniciando, base de datos no lista aún. Intenta de nuevo en 2–3 segundos."
    });
  }
  next();
});

// ================================
// MODELO — ITEM
// ================================
const ItemSchema = new mongoose.Schema({
  nombre: { type: String, required: true, trim: true, lowercase: true },
  programa: { type: String, trim: true },
  ficha: { type: String, required: true, trim: true },
  progreso: { type: Number },
  fecha: { type: Date },

  encuesta: {
    intentos: { type: Number },
    observacion: { type: String },
    fecha: { type: Date }
  }
}, { timestamps: true });

// Índice único
ItemSchema.index(
  { nombre: 1, ficha: 1 },
  { unique: true, collation: { locale: 'es', strength: 2 } }
);

const Item = mongoose.model("Item", ItemSchema);

// Sincronizar índices
Item.syncIndexes()
  .then(() => console.log("✅ Índices sincronizados"))
  .catch(err => console.error("❌ Error al sincronizar índices:", err));


// ================================
// RUTAS
// ================================

// Ruta de prueba
app.get('/', (req, res) => res.send("API funcionando 🚀"));


// --------------------------------
// GUARDAR OBSERVACIÓN
// --------------------------------
app.post("/guardarTodo", async (req, res) => {
  try {
    const { nombre, ficha, observacion } = req.body;

    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      item = new Item({
        nombre,
        ficha,
        encuesta: { observacion, fecha: new Date() }
      });
    } else {
      if (!item.encuesta) item.encuesta = {};
      item.encuesta.observacion = observacion;
      item.encuesta.fecha = new Date();
    }

    await item.save();
    res.json({ mensaje: "✅ Guardado con encuesta (observación)", item });

  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});


// --------------------------------
// GUARDAR INTENTOS
// --------------------------------
app.post("/guardarintentos", async (req, res) => {
  try {
    const { nombre, ficha, intentos } = req.body;

    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      item = new Item({
        nombre,
        ficha,
        encuesta: { intentos, fecha: new Date() }
      });
    } else {
      if (!item.encuesta) item.encuesta = {};
      item.encuesta.intentos = intentos;
      item.encuesta.fecha = new Date();
    }

    await item.save();
    res.json({ mensaje: "✅ Intentos guardados correctamente", item });

  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});


// --------------------------------
// GUARDAR PROGRESO DIRECTO
// --------------------------------
app.post("/guardarProgreso", async (req, res) => {
  try {
    const { nombre, ficha, progreso } = req.body;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    if (progreso === undefined) {
      return res.status(400).json({ mensaje: "progreso es requerido" });
    }

    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      item = new Item({ nombre, ficha, progreso });
    } else {
      item.progreso = Math.min(progreso, 100);
    }

    await item.save();

    res.json({
      mensaje: "✅ Progreso actualizado",
      progreso: item.progreso,
      completado: item.progreso >= 100
    });

  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});


// --------------------------------
// OBTENER PROGRESO
// --------------------------------
app.get("/progreso", async (req, res) => {
  try {
    const { nombre, ficha } = req.query;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    const item = await Item.findOne(
      {
        nombre: { $regex: '^' + nombre + '$', $options: 'i' },
        ficha
      },
      { progreso: 1, _id: 0 }
    );

    if (!item) {
      return res.status(404).json({ mensaje: "❌ No se encontró ningún registro con ese nombre y ficha" });
    }

    res.json({
      mensaje: "✅ Progreso encontrado",
      progreso: item.progreso ?? 0
    });

  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});


// --------------------------------
// LISTAR ITEMS
// --------------------------------
app.get('/items', async (req, res) => {
  try {
    const { page = 1, limit = 10, nombre, ficha, programa } = req.query;

    const filtros = {};
    if (nombre) filtros.nombre = new RegExp(nombre, "i");
    if (ficha) filtros.ficha = ficha;
    if (programa) filtros.programa = new RegExp(programa, "i");

    const skip = (page - 1) * limit;
    const total = await Item.countDocuments(filtros);

    const items = await Item.find(filtros)
      .skip(skip)
      .limit(parseInt(limit))
      .sort({ createdAt: -1 });

    res.json({
      total,
      page: parseInt(page),
      pages: Math.ceil(total / limit),
      items
    });

  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});


// --------------------------------
// CREAR ITEM O REEMPLAZAR
// --------------------------------
app.post('/items', async (req, res) => {
  try {
    const { nombre, ficha } = req.body;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    try {
      const nuevoItem = await Item.create(req.body);
      return res.status(201).json({ reemplazado: false, item: nuevoItem });

    } catch (err) {
      if (err.code === 11000) {
        const actualizado = await Item.findOneAndUpdate(
          { nombre, ficha },
          { $set: req.body },
          { new: true, runValidators: true }
        );

        return res.status(200).json({ reemplazado: true, item: actualizado });
      }
      throw err;
    }

  } catch (err) {
    res.status(400).json({ mensaje: err.message });
  }
});


// ================================
// SERVIDOR
// ================================
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
