import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/product.dart';
import 'package:frontend_flutter/services/api_service.dart';

class EditPage extends StatefulWidget {
  final Product product;

  const EditPage({super.key, required this.product});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController hargaController;
  late TextEditingController stokController;
  late TextEditingController deskripsiController;

  final ApiService api = ApiService();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.nama);
    hargaController =
        TextEditingController(text: widget.product.harga.toString());
    stokController =
        TextEditingController(text: widget.product.stok.toString());
    deskripsiController = TextEditingController(text: widget.product.deskripsi);
  }

  @override
  void dispose() {
    nameController.dispose();
    hargaController.dispose();
    stokController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });

    Product product = Product(
      id: widget.product.id,
      nama: nameController.text,
      harga: double.parse(hargaController.text),
      stok: int.parse(stokController.text),
      deskripsi: deskripsiController.text,
    );

    bool berhasil = await api.updateProduct(product);

    setState(() {
      loading = false;
    });

    if (berhasil) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil di update")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Data gagal di update")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Produk"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: "Nama Produk",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shopping_bag)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: hargaController,
                  decoration: const InputDecoration(
                      labelText: "Harga Produk",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.price_check_sharp)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harga produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: stokController,
                  decoration: const InputDecoration(
                      labelText: "Stok Produk",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.tag)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Stok produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(
                      labelText: "Deskripsi Produk",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Deskripsi produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                      onPressed: loading ? null : simpanData,
                      icon: loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.save),
                      label: Text(loading ? "Mengupdate..." : "UPDATE")),
                )
              ],
            )),
      ),
    );
  }
}
