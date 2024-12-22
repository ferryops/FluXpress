const db = require("../config/database");

// Get All Barang
const getAllBarang = async (req, res) => {
  try {
    const [results] = await db.query("SELECT * FROM barang");
    res.json(results);
  } catch (error) {
    res.status(500).json({ message: "Error fetching data", error });
  }
};

// Get Barang by ID
const getBarangById = async (req, res) => {
  const { id } = req.params;
  try {
    const [results] = await db.query("SELECT * FROM barang WHERE id = ?", [id]);
    if (results.length === 0) {
      return res.status(404).json({ message: "Barang not found" });
    }
    res.json(results[0]);
  } catch (error) {
    res.status(500).json({ message: "Error fetching data", error });
  }
};

// Create Barang
const createBarang = async (req, res) => {
  const { nama, harga, stok } = req.body;
  try {
    const [result] = await db.query("INSERT INTO barang (nama, harga, stok) VALUES (?, ?, ?)", [nama, harga, stok]);
    res.status(201).json({ message: "Barang created", id: result.insertId });
  } catch (error) {
    res.status(500).json({ message: "Error creating barang", error });
  }
};

// Update Barang
const updateBarang = async (req, res) => {
  const { id } = req.params;
  const { nama, harga, stok } = req.body;
  try {
    const [result] = await db.query("UPDATE barang SET nama = ?, harga = ?, stok = ? WHERE id = ?", [nama, harga, stok, id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Barang not found" });
    }
    res.json({ message: "Barang updated" });
  } catch (error) {
    res.status(500).json({ message: "Error updating barang", error });
  }
};

// Delete Barang
const deleteBarang = async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query("DELETE FROM barang WHERE id = ?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Barang not found" });
    }
    res.json({ message: "Barang deleted" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting barang", error });
  }
};

module.exports = {
  getAllBarang,
  getBarangById,
  createBarang,
  updateBarang,
  deleteBarang,
};
