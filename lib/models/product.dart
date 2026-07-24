class Product {
  int? id;
  String nama;
  double harga;
  int stok;
  String deskripsi;
  String? gambar;

  Product({required this.id, required this.nama, required this.harga, required this.stok, required this.deskripsi, this.gambar});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'].toDouble(),
      stok: json['stok'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'deskripsi': deskripsi,
      'gambar': gambar
    };
  }
}