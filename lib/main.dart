import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/home_page.dart';
import 'package:frontend_flutter/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> cekLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token")!=null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CRUD  laravel flutter",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
      ),
      home: FutureBuilder<bool>(
        future: cekLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }         
}