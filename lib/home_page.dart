import 'package:flutter/material.dart';
import 'package:labmobile3/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var namauser;

  void _loadUsername() async {
    // Inisialisasi SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil username yang sudah tersimpan
    namauser = prefs.getString('username');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _loadUsername();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Text('Ini adalah halaman User $namauser'),
      ),
      drawer: const Sidemenu(),
    );
  }
}
