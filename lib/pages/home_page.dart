import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page!'),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('This is the Home page'),
      ),
    );
  }
}