import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/product.dart';
import 'package:frontend_flutter/screens/edit_page.dart';

class DetailProduct extends StatelessWidget {
  final Product product;

  const DetailProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk", style: TextStyle(fontWeight: FontWeight.bold),),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
                tag: product.id!,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                    child: Icon(
                      Icons.computer_rounded,
                      size: 120,
                      color: Colors.deepOrange,
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nama,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Rp ${product.harga}",
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.inventory),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Stok: ${product.stok}",
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      height: 35,
                    ),
                    const Text(
                      "Deskripsi",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.deskripsi,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit, color: Colors.blue,),
                label: const Text("Edit Produk"),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditPage(product: product)));
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text("Kembali"),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
