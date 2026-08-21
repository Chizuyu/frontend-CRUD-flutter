import 'dart:convert';
import 'package:frontend_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  
  Future<List<Product>> getProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")??"";
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers:{
      "Authorization":"Bearer $token",
      "accept":"application/json"
      },
    );
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("gagal mengambil data");
    }
  }

  Future<bool> storeProducts(Product product, File? image) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")??"";
    var request = http.MultipartRequest(
      "POST", Uri.parse("$baseUrl/products"),
    );
    request.headers.addAll({
      "Authorization":"Bearer $token",
      "accept":"application/json"
    });
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")??"";
    final response = await http.put(
      Uri.parse("$baseUrl/products/${product.id}"),
      headers: {
        "Authorization":"Bearer $token",
        "accept":"application/json"
      },
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")??"";
    final response = await http.delete(
      Uri.parse("$baseUrl/products/$id"),
      headers: {
        "Authorization":"Bearer $token",
        "accept":"application/json"
      },
    );
    return response.statusCode == 200;
  }

  Future<String?>login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {
        "email":email,
        "password":password,
      }
    );
    if (response.statusCode==200){
      final data = jsonDecode(response.body);
      return data["token"];
    }
    return null;
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")??"";
    await http.post(
      Uri.parse("$baseUrl/logout"),
      headers: {
        "Authorization":"Bearer $token",
        "accept":"application/json"
      },
    );
    await pref.remove("token");
  }
}
