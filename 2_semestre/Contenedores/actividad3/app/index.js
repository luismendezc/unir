const express = require("express");
const { Pool } = require("pg");

const app = express();
const port = process.env.PORT || 3000;

// Cadena de conexión vía variables de entorno
const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

app.get("/health", (_req, res) => res.send("OK"));

app.get("/time", async (_req, res) => {
  const { rows } = await pool.query("SELECT NOW() as now");
  res.json(rows[0]);
});

app.get("/product/:id", async (req, res) => {
  try {
    const { rows } = await pool.query(
      "SELECT name, price FROM products WHERE id = $1",
      [req.params.id]
    );
    if (rows.length === 0) return res.status(404).json({ error: "Not found" });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Error querying DB", details: err.message });
  }
});

app.listen(port, () => console.log(`API escuchando en ${port}`));
