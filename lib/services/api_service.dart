import 'dart:convert';
import 'package:frontend_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  
  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse("${baseUrl}/products"),
    );
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("gagal mengambil data");
    }
  }

  Future<bool> storeProducts(Product product, File? image) async {
    var request = http.MultipartRequest(
      "POST", Uri.parse("${baseUrl}/products"),
    );
    request.fields["nama"] = product.nama;
    request.fields["harga"] = product.harga.toString(); 
    request.fields["stok"] = product.stok.toString();
    request.fields["deskripsi"] = product.deskripsi;

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "gambar", image.path,
        )
      );
    }
    var response = await request.send();
    return response.statusCode == 201;
  } 

  Future<bool> updateProducts(Product product) async {
    final response = await http.put(
      Uri.parse("${baseUrl}/products/${product.id}"),
      body: {
        "nama" : product.nama,
        "harga" : product.harga.toString(),
        "stok" : product.stok.toString(),
        "deskripsi" : product.deskripsi,
      }
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse("${baseUrl}/products/$id"),
    );
    return response.statusCode == 200;
  }
}
