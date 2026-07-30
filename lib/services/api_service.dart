import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/models/product.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
    );

    if (response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      return jsonData
      .map((e)=> Product.fromJson(e))
      .toList();
    }else{
      throw Exception("Gagal mengambil data");
    }
  }

  Future<bool>storeProducts(
    Product product
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/products"),
      body: {
        "nama":product.nama,
        "harga":product.harga.toString(),
        "stok":product.stok.toString(),
        "deskripsi":product.deskripsi
      },
    );
    return response.statusCode == 201;
  }
}