import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/home_page.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiService api = ApiService();
  bool isLoading = false;

  Future<void>login() async {
    String? token=await api.login(
      emailController.text,
      passwordController.text
    );
    if(token != null){
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_)=>const HomePage()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login gagal"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(
                  Icons.shopping_basket,
                  size: 50,
                  color: Colors.cyan,
                ),
                const SizedBox(height: 15),
                const Text(
                  "Aplikasi CRUD XII RPL 2",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
