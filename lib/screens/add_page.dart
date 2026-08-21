import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/product.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();
  final ApiService api = ApiService();
  bool loading = false;
  File? image;
  final picker = ImagePicker();

  Future<void> pilihGambar() async {
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future<void> SimpanData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    Product product = Product(
      nama: namaController.text,
      harga: double.parse(hargaController.text),
      stok: int.parse(stokController.text),
      deskripsi: deskripsiController.text,
    );
    bool berhasil = await api.storeProducts(product,image);
    setState(() {
      loading = false;
    });
    if (berhasil) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('product Berhasil ditamabahkan'),
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Produk Gagal diTambahkan')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Tambah Produk'),
            centerTitle: true,
            backgroundColor: Colors.orange),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Column(children: [
              Center(
                child: GestureDetector(
                  onTap: pilihGambar,
                  child: image == null
                      ? Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 113, 10, 10)),
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 60,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            image!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          labelText: "nama Produk",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.shopping_bag),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "nama Produk Wajib Diisi";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: hargaController,
                        decoration: const InputDecoration(
                          labelText: "harga Produk",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.money),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "harga Produk Wajib Diisi";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: stokController,
                        decoration: const InputDecoration(
                          labelText: "stok Produk",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.inventory),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "stok Produk Wajib Diisi";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: deskripsiController,
                        decoration: const InputDecoration(
                          labelText: "deskripsi Produk",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "deskripsi Produk Wajib Diisi";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: loading ? null : SimpanData,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white),
                          icon: loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.deepPurple,
                                  ),
                                )
                              : const Icon(Icons.save),
                          label: Text(
                            loading ? 'Menyimpan' : 'Simpan',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]
           )
         )
      )
     );
  }


}
