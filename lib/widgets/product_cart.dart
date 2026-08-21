import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/product.dart';
import 'package:frontend_flutter/screens/edit_page.dart';
import 'package:frontend_flutter/services/api_service.dart';

class ProductCart extends StatelessWidget {
  final Product product;
  final VoidCallback onRefresh;
  final VoidCallback onDetail;
  const ProductCart(
      {super.key,
      required this.product,
      required this.onRefresh,
      required this.onDetail});

  @override
  Widget build(BuildContext context) {
    final ApiService api = ApiService();

    return InkWell(
      onTap: onDetail,
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: product.gambar == null || product.gambar!.isEmpty
                            ? Image.asset(
                                "assets/image1.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "http://127.0.0.1:8000/storage/products/${product.gambar}",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/image1.jpg",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                );
                              }
                            )
                           ),
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final hasil = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditPage(product: product),
                            ),
                          );

                          if (hasil == true) {
                            onRefresh();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          bool? setuju = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Hapus Produk"),
                              content: const Text(
                                  "Yakin ingin menghapus produk ini?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Hapus"),
                                ),
                              ],
                            ),
                          );

                          if (setuju == true) {
                            bool berhasil =
                                await api.deleteProduct(product.id!);

                            if (context.mounted) {
                              if (berhasil) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Data berhasil dihapus")),
                                );
                                onRefresh(); // Refresh halaman utama
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Gagal menghapus data")),
                                );
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.attach_money),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Rp${product.harga}",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.inventory),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Stok: ${product.stok}",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20),
                  ),
                ],
              ),
              const Divider(
                height: 25,
              ),
              // Text(
              //   product.deskripsi,
              //   style: const TextStyle(
              //       fontWeight: FontWeight.normal, fontSize: 20),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
