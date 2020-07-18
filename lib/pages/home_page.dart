import 'package:EasyAuth/pages/authenticate_page.dart';
import 'package:EasyAuth/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final String userName;
  HomePage({this.userName});
  
  final AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page', style: TextStyle(fontSize: 24.0)),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await authService.signOut();

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthenticatePage()), (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            label: Text('Sign out', style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Center(
        child: Text('Welcome back, $userName', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}