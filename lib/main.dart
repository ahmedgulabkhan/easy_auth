import 'package:EasyAuth/helper/helper_functions.dart';
import 'package:EasyAuth/pages/authenticate_page.dart';
import 'package:EasyAuth/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getIsLoggedIn();
  }
  _getIsLoggedIn() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((result) {
      if(result != null) {
        setState(() {
          _isLoggedIn = result;
        });
      }
    });

    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading ? Container(color: Colors.black87) : MaterialApp(
      title: 'EasyAuth',
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? HomePage() : AuthenticatePage(),
    );
  }
}
