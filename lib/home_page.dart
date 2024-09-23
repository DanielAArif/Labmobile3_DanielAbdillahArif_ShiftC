import 'package:flutter/material.dart';
import 'package:labmobile3/sidemenu.dart';
import 'package:labmobile3/quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: SideMenu(),  // Menambahkan SideMenu
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizPage()),
            );
          },
          child: Text('Start Quiz'),
        ),
      ),
    );
  }
}
