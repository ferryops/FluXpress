require("dotenv").config();
const express = require("express");
const barangRoutes = require("./routes/barangRoutes");

const app = express();
const PORT = 3000;

// Middleware
app.use(express.json());

// Routes
app.use("/api/barang", barangRoutes);

// Start Server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
