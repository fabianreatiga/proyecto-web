const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

console.log('MONGO_URI:', process.env.MONGO_URI);


// Middleware
app.use(cors());
app.use(express.json());

// Conexión a MongoDB
console.log('MONGO_URI:', process.env.MONGO_URI);

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})

  .then(() => console.log("✅ Conectado a MongoDB"))
  .catch(err => console.error("❌ Error al conectar a MongoDB:", err));


// =======================
// MODELO
// =======================
/*const ItemSchema = new mongoose.Schema({
  nombre: { type: String, required: true, trim: true, lowercase: true },
  programa: { type: String, trim: true},
  ficha: { type: String, required: true, trim: true },
  progreso: { type: Number,},
  fecha: { type: Date }, 
}, { timestamps: true });
*/
const ItemSchema = new mongoose.Schema({
  nombre: { type: String, required: true, trim: true, lowercase: true },
  programa: { type: String, trim: true },
  ficha: { type: String, required: true, trim: true },
  progreso: { type: Number },
  fecha: { type: Date },

  // 📌 Encuesta asociada directamente al aprendiz
  encuesta: {
    intentos: { type: Number },
    observacion: { type: String },  
  }

}, { timestamps: true });

app.post("/guardarTodo", async (req, res) => {
  try {
    const { nombre, ficha, observacion } = req.body;

    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      item = new Item({
        nombre,
        ficha,
        encuesta: { observacion }
      });
    } else {
      // ✅ Solo actualiza el campo observacion
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


app.post("/guardarintentos", async (req, res) => {
  try {
    const { nombre, ficha, intentos } = req.body;

    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      item = new Item({
        nombre,
        ficha,
        encuesta: { intentos }
      });
    } else {
      // ✅ Solo actualiza el campo intentos
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



ItemSchema.index(//nuevo
  { nombre: 1, ficha: 1 },
  { unique: true, collation: { locale: 'es', strength: 2 } }
);

const Item = mongoose.model('Item', ItemSchema);

// Asegurar que los índices del esquema estén aplicados en Mongo
Item.syncIndexes()
  .then(() => console.log("✅ Índices sincronizados"))
  .catch(err => console.error("❌ Error al sincronizar índices:", err));

// =======================
// RUTAS
// =======================

// Ruta de prueba
app.get('/', (req, res) => res.send('API funcionando 🚀'));

// Obtener todos los items con filtros y paginación
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

// Crear item (si ya existe con mismo nombre+ficha → se reemplaza)
app.post('/items', async (req, res) => {
  try {
    const { nombre, ficha } = req.body;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: 'nombre y ficha son requeridos' });
    }

    // Intentar crear
    try {
      const nuevoItem = await Item.create(req.body);
      return res.status(201).json({ reemplazado: false, item: nuevoItem });
    } catch (err) {
      // Si ya existe → reemplazar
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

// Obtener item por ID
app.get('/items/:id', async (req, res) => {
  try {
    const item = await Item.findById(req.params.id);
    if (!item) return res.status(404).json({ mensaje: 'Item no encontrado' });
    res.json(item);
  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});

/*app.post("/guardarProgreso", async (req, res) => { en caso de que no funcione este es el codigo anterior
  try {
    const { nombre, ficha } = req.body;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      // Si no existe lo creamos con progreso inicial en 2
      item = new Item({ nombre, ficha, progreso: 0 });
    } else {
      // 👉 Validar que no pase de 100
      if (item.progreso < 100) {
        item.progreso = Math.min(item.progreso + 2, 100); // nunca mayor a 100
      }
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
});*/
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
      // Crear nuevo con progreso recibido
      item = new Item({ nombre, ficha, progreso });
    } else {
      // Actualizar el progreso recibido (limitado a 100)
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




app.get("/progreso", async (req, res) => {
  try {
    const { nombre, ficha } = req.query;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    // Buscar por nombre (sin importar mayúsculas)
    const item = await Item.findOne(
      {
        nombre: { $regex: '^' + nombre + '$', $options: 'i' },
        ficha: ficha
      },
      { progreso: 1, _id: 0 } // 👉 Solo devolver el campo progreso
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

app.get("/progreso", async (req, res) => {
  try {
    const { nombre, ficha } = req.query;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    const nombreLower = nombre.toLowerCase();

    const item = await Item.findOne(
      { nombre: nombreLower, ficha },
      { progreso: 1, _id: 0 }
    )
    .collation({ locale: "es", strength: 2 });

    if (!item) {
      return res.status(404).json({ mensaje: "❌ No encontrado" });
    }

    res.json({
      mensaje: "✅ Progreso encontrado",
      progreso: item.progreso ?? 0
    });

  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});



// Guardar progreso (+2 cada vez)
/*app.post("/guardarProgreso", async (req, res) => {
  try {
    const { nombre, ficha, progreso } = req.body;

    if (!nombre || !ficha) {
      return res.status(400).json({ mensaje: "nombre y ficha son requeridos" });
    }

    // Buscar el registro del usuario
    let item = await Item.findOne({ nombre, ficha });

    if (!item) {
      // Si no existe, lo creamos
      item = new Item({ nombre, ficha, progreso: [progreso] });
    } else {
      // Si existe, agregamos el nuevo progreso (suma de 2 en 2)
      item.progreso.push(progreso);
    }

    await item.save();
    res.json({ mensaje: "✅ Progreso guardado", progreso: item.progreso });
  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});*/


/*app.post("/guardarProgreso", async (req, res) => {
  try {
    const { progreso } = req.body;

    if (progreso === undefined) {
      return res.status(400).json({ mensaje: "El campo 'progreso' es requerido" });
    }

    // 👉 Aquí decides cómo identificar al usuario
    // Supongamos que ya tienes el usuario en sesión o en la base de datos
    // y solo necesitas actualizarle el progreso
    const usuario = await Usuario.findOne(); // o busca por ID en sesión/token

    if (!usuario) {
      return res.status(404).json({ mensaje: "Usuario no encontrado" });
    }

    usuario.progreso = progreso;
    await usuario.save();

    res.status(200).json({ mensaje: "✅ Progreso actualizado", progreso });
  } catch (error) {
    console.error("❌ Error al guardar progreso:", error);
    res.status(500).json({ mensaje: "Error al guardar progreso" });
  }
});*/


// =======================
// MODELO ENCUESTA
// =======================
/*const EncuestaSchema = new mongoose.Schema({
  diseno: { type: String, required: true },
  facil: { type: String, required: true },
  util: { type: String, required: true },
  organizacion: { type: String, required: true },
  fecha: { type: Date, default: Date.now }
}, { timestamps: true });

const Encuesta = mongoose.model("Encuesta", EncuestaSchema);


// =======================
// RUTA ENCUESTA
// =======================
app.post("/encuestas", async (req, res) => {
  try {
    const { diseno, facil, util, organizacion } = req.body;

    if (!diseno || !facil || !util || !organizacion) {
      return res.status(400).json({ mensaje: "Todos los campos son requeridos" });
    }

    const nuevaEncuesta = new Encuesta({ diseno, facil, util, organizacion });
    await nuevaEncuesta.save();

    res.status(201).json({ mensaje: "✅ Encuesta guardada", encuesta: nuevaEncuesta });
  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});

// Obtener todas las encuestas
app.get("/encuestas", async (req, res) => {
  try {
    const encuestas = await Encuesta.find().sort({ createdAt: -1 });
    res.json(encuestas);
  } catch (err) {
    res.status(500).json({ mensaje: err.message });
  }
});
*/


// =======================
// SERVIDOR
// =======================
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});