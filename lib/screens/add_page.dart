import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/product.dart';
import 'package:frontend_flutter/services/api_service.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();

  final ApiService api = ApiService();
  bool loading = false;

  Future<void>simpanData()async{
    if(!_formKey.currentState!.validate()){
      return;
    }
    setState(() {
      loading = true;
    });
    Product product = Product(
      nama: nameController.text,
      harga: double.parse(hargaController.text),
      stok: int.parse(stokController.text),
      deskripsi: deskripsiController.text,  
    );
    bool berhasil = await api.storeProducts(product);
    setState(() {
      loading = false;
    });

    if(berhasil){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data berhasil di tambahkan")));
      Navigator.pop(context,true);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data gagal di tambahkan")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Produk"
        ),
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
                    prefixIcon: Icon(Icons.shopping_bag)
                  ),
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Nama produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: hargaController,
                  decoration: const InputDecoration(
                    labelText: "Harga Produk",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.price_check_sharp)
                  ),
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Harga produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: stokController,
                  decoration: const InputDecoration(
                    labelText: "Stok Produk",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.tag)
                  ),
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Stok produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(
                    labelText: "Deskripsi Produk",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description)
                  ),
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Deskripsi produk wajib di isi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                SizedBox( 
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: loading?null:simpanData, 
                    icon: loading
                    ?const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    :const Icon(Icons.save),
                    label:Text(loading ?"Menyimpan...":"SIMPAN")
                  ),
                )
              ],
            )
          ),
        ),
    );
  }
}