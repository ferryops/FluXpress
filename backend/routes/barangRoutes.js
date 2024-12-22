const express = require("express");
const { getAllBarang, getBarangById, createBarang, updateBarang, deleteBarang } = require("../controllers/barangController");

const router = express.Router();

router.get("/", getAllBarang);
router.get("/:id", getBarangById);
router.post("/", createBarang);
router.put("/:id", updateBarang);
router.delete("/:id", deleteBarang);

module.exports = router;
