import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Nama : Theresia Christine Lerebulan
// NIM : 210101010007
// Kelas : 701
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Barang',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BarangPage(),
    );
  }
}

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  final String apiUrl = 'http://localhost:3000/api/barang';
  List<dynamic> _barang = [];

  @override
  void initState() {
    super.initState();
    fetchBarang();
  }

  Future<void> fetchBarang() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        _barang = json.decode(response.body);
      });
    } else {
      throw Exception('Gagal mengambil data barang');
    }
  }

  Future<void> addBarang(String nama, String harga, String stok) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama': nama,
        'harga': double.parse(harga),
        'stok': int.parse(stok),
      }),
    );
    if (response.statusCode == 201) {
      fetchBarang();
    }
  }

  Future<void> updateBarang(
      int id, String nama, String harga, String stok) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama': nama,
        'harga': double.parse(harga),
        'stok': int.parse(stok),
      }),
    );
    if (response.statusCode == 200) {
      fetchBarang();
    }
  }

  Future<void> deleteBarang(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      fetchBarang();
    }
  }

  void showBarangDialog({int? id, String? nama, String? harga, String? stok}) {
    final TextEditingController namaController =
        TextEditingController(text: nama);
    final TextEditingController hargaController =
        TextEditingController(text: harga);
    final TextEditingController stokController =
        TextEditingController(text: stok);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Tambah Barang' : 'Edit Barang'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (id == null) {
                  addBarang(
                    namaController.text,
                    hargaController.text,
                    stokController.text,
                  );
                } else {
                  updateBarang(
                    id,
                    namaController.text,
                    hargaController.text,
                    stokController.text,
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Barang'),
      ),
      body: ListView.builder(
        itemCount: _barang.length,
        itemBuilder: (context, index) {
          final item = _barang[index];
          return ListTile(
            title: Text(item['nama']),
            subtitle: Text('Harga: ${item['harga']} - Stok: ${item['stok']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => showBarangDialog(
                    id: item['id'],
                    nama: item['nama'],
                    harga: item['harga'].toString(),
                    stok: item['stok'].toString(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteBarang(item['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBarangDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
