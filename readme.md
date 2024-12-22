# FluXpress (Flutter + Express) simpel CRUD Barang

Project ini merupakan aplikasi CRUD sederhana untuk mengelola data barang. Aplikasi ini terdiri dari dua bagian:

- **Backend**: Dibangun menggunakan Express.js dan MySQL.
- **Frontend**: Dibangun menggunakan Flutter.

## Struktur Folder

```
project-folder
├── backend
│   ├── controllers
│   │   └── barangController.js
│   ├── config
│   │   └── database.js
│   ├── routes
│   │   └── barangRoutes.js
│   └── server.js
└── frontend
    └── lib
        └── main.dart
```

## Backend

Backend menyediakan API untuk mengelola data barang, meliputi operasi berikut:

1. **GET** `/api/barang` - Mendapatkan semua data barang.
2. **GET** `/api/barang/:id` - Mendapatkan data barang berdasarkan ID.
3. **POST** `/api/barang` - Menambahkan barang baru.
4. **PUT** `/api/barang/:id` - Memperbarui data barang berdasarkan ID.
5. **DELETE** `/api/barang/:id` - Menghapus data barang berdasarkan ID.

### Cara Menjalankan Backend

1. Pastikan Node.js sudah terinstal.
2. Buat file `database.js` di folder `config` dengan isi seperti berikut:

```javascript
const mysql = require("mysql2/promise");

const db = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "yourpassword",
  database: "yourdatabase",
});

module.exports = db;
```

3. Install dependencies dengan perintah:
   ```bash
   npm install
   ```
4. Jalankan server dengan perintah:
   ```bash
   npm start
   ```
5. Backend akan berjalan di `http://localhost:3000`.

### MySQL Database

Pastikan Anda memiliki database MySQL dengan nama `yourdatabase` dan tabel `barang` yang sudah dibuat. Jika belum, Anda dapat membuatnya menggunakan skrip SQL berikut:

```sql
-- Create Table barang
CREATE TABLE barang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    harga DECIMAL(15,2) NOT NULL,
    stok INT NOT NULL
);

-- Insert Data into barang
INSERT INTO barang (nama, harga, stok) VALUES
('Laptop ASUS ROG', 15000000.00, 10),
('Mouse Logitech G502', 850000.00, 25),
('Keyboard Razer BlackWidow', 2000000.00, 15),
('Monitor LG UltraWide', 5000000.00, 8),
('Headset HyperX Cloud II', 1200000.00, 20),
('Printer Canon Pixma', 2500000.00, 12),
('Hard Disk WD 1TB', 750000.00, 30),
('SSD Samsung EVO 500GB', 1000000.00, 18),
('RAM Corsair 16GB', 1500000.00, 10),
('Power Supply Cooler Master 750W', 1250000.00, 6);
```

## Frontend

Frontend adalah aplikasi Flutter yang menyediakan antarmuka pengguna untuk berinteraksi dengan API backend.

### Fitur Utama

- Menampilkan daftar barang.
- Menambahkan barang baru.
- Mengedit barang.
- Menghapus barang.

### Cara Menjalankan Frontend

1. Pastikan Flutter SDK sudah terinstal.
2. Buka folder `frontend` di terminal.
3. Jalankan aplikasi dengan perintah:
   ```bash
   flutter run
   ```

### Catatan

Ubah URL API di file `main.dart` agar sesuai dengan alamat server backend Anda:

```dart
final String apiUrl = 'http://localhost:3000/api/barang';
```

## Kontribusi

Kontribusi sangat diterima! Jika Anda menemukan bug atau memiliki ide untuk fitur baru, silakan buat pull request atau buka issue.
