const express = require('express');
const mysql = require('mysql2');
const moment = require('moment-timezone'); // Importar moment-timezone para manejar fechas y horas con zona horaria

const app = express();
const port = 3000;

// Middleware para parsear el cuerpo de las solicitudes como JSON
app.use(express.json());

// Configuración de la conexión a la base de datos
const db = mysql.createConnection({
    host: 'localhost',  // Cambia esto si tu base de datos está en otro host
    user: 'root',       // Tu usuario de MySQL
    password: '',       // Tu contraseña de MySQL
    database: 'ferramas'   // El nombre de tu base de datos
});

// Conectar a la base de datos
db.connect(err => {
    if (err) {
        console.error('Error conectando a la base de datos:', err);
        return;
    }
    console.log('Conectado a la base de datos MySQL');
});

// Ruta para obtener todos los productos
app.get('/api/productos', (req, res) => {
    db.query('SELECT * FROM core_producto', (err, results) => {
        if (err) {
            res.status(500).send('Error obteniendo productos: ' + err.message);
            return;
        }
        res.json(results);
    });
});

// Ruta para obtener un producto por su ID
app.get('/api/productos/:id', (req, res) => {
    const id = req.params.id;
    db.query('SELECT * FROM core_producto WHERE id = ?', [id], (err, results) => {
        if (err) {
            res.status(500).send('Error obteniendo producto: ' + err.message);
            return;
        }
        if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.status(404).send('Producto no encontrado');
        }
    });
});

// Ruta para crear un nuevo producto
app.post('/api/productos', (req, res) => {
    const { id, imagen, nombre, descripcion, precio, stock, marca_id, tipo_id } = req.body;
    const ahoraEnSantiago = moment().tz('America/Santiago'); // Obtener fecha y hora actual en Santiago
    const creado_en = ahoraEnSantiago.format('YYYY-MM-DD HH:mm:ss'); // Formato para MySQL
    const modificado_en = ahoraEnSantiago.format('YYYY-MM-DD HH:mm:ss'); // Inicialmente modificado_en es igual a creado_en

    // Consulta SQL para la inserción de datos
    const sql = 'INSERT INTO core_producto (id, imagen, nombre, descripcion, precio, stock, creado_en, modificado_en, marca_id, tipo_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

    // Valores para insertar, en el orden correspondiente a la consulta SQL
    const values = [id, imagen, nombre, descripcion, precio, stock, creado_en, modificado_en, marca_id, tipo_id];

    // Ejecutar la consulta SQL con los valores correspondientes
    db.query(sql, values, (err, result) => {
        if (err) {
            console.error('Error al insertar producto:', err);
            res.status(500).send('Error al crear producto: ' + err.message);
            return;
        }

        // Si la inserción fue exitosa, devolver el nuevo producto creado
        db.query('SELECT * FROM core_producto WHERE id = ?', [result.insertId], (err, results) => {
            if (err) {
                console.error('Error al obtener el nuevo producto:', err);
                res.status(500).send('Error al obtener el nuevo producto: ' + err.message);
                return;
            }
            if (results.length > 0) {
                res.status(201).json(results[0]);
            } else {
                res.status(404).send('Producto creado pero no encontrado en la base de datos');
            }
        });
    });
});

// Ruta para actualizar un producto
app.put('/api/productos/:id', (req, res) => {
    const id = req.params.id;
    const { nombre, descripcion, precio, imagen, stock, marca_id, tipo_id } = req.body;
    const ahoraEnSantiago = moment().tz('America/Santiago'); // Obtener fecha y hora actual en Santiago
    const modificado_en = ahoraEnSantiago.format('YYYY-MM-DD HH:mm:ss'); // Formato para MySQL

    // Consulta SQL para actualizar los datos del producto
    const sql = 'UPDATE core_producto SET nombre = ?, descripcion = ?, precio = ?, imagen = ?, stock = ?, modificado_en = ?, marca_id = ?, tipo_id = ? WHERE id = ?';

    // Valores para actualizar, en el orden correspondiente a la consulta SQL
    const values = [nombre, descripcion, precio, imagen, stock, modificado_en, marca_id, tipo_id, id];

    // Ejecutar la consulta SQL con los valores correspondientes
    db.query(sql, values, (err, result) => {
        if (err) {
            console.error('Error al actualizar producto:', err);
            res.status(500).send('Error al actualizar producto: ' + err.message);
            return;
        }
        if (result.affectedRows > 0) {
            // Si se actualizó correctamente, obtener el producto actualizado y devolverlo como respuesta
            db.query('SELECT * FROM core_producto WHERE id = ?', [id], (err, results) => {
                if (err) {
                    console.error('Error al obtener producto actualizado:', err);
                    res.status(500).send('Error al obtener producto actualizado: ' + err.message);
                    return;
                }
                if (results.length > 0) {
                    res.json(results[0]);
                } else {
                    res.status(404).send('Producto actualizado pero no encontrado en la base de datos');
                }
            });
        } else {
            res.status(404).send('Producto no encontrado para actualizar');
        }
    });
});

// Ruta para eliminar un producto
app.delete('/api/productos/:id', (req, res) => {
    const id = req.params.id;
    db.query('DELETE FROM core_producto WHERE id = ?', [id], (err, result) => {
        if (err) {
            res.status(500).send('Error eliminando producto: ' + err.message);
            return;
        }
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).send('Producto no encontrado para eliminar');
        }
    });
});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`API escuchando en http://localhost:${port}`);
});
