import 'package:EasyAuth/helper/helper_functions.dart';
import 'package:EasyAuth/pages/home_page.dart';
import 'package:EasyAuth/services/auth_service.dart';
import 'package:EasyAuth/shared/constants.dart';
import 'package:EasyAuth/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // text field state
  String fullName = '';
  String email = '';
  String password = '';
  String error = '';

  _onRegister() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _auth.registerWithEmailAndPassword(fullName, email, password).then((result) async {
        if (result != null) {
          await HelperFunctions.saveUserLoggedInSharedPreference(true);
          await HelperFunctions.saveUserEmailSharedPreference(email);
          await HelperFunctions.saveUserNameSharedPreference(fullName);

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(userName: fullName)));
        }
        else {
          setState(() {
            error = 'Error while registering the user!';
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Register", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
                    
                  SizedBox(height: 30.0),

                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Full Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, color: Colors.white)
                    ),
                    validator: (val) => val.isEmpty ? 'This field cannot be blank' : null,
                    onChanged: (val) {
                      setState(() {
                        fullName = val;
                      });
                    },
                  ),
                    
                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.alternate_email, color: Colors.white),
                    ),
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Please enter a valid email";
                    },
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                    
                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                    ),
                    validator: (val) => val.length < 6 ? 'Password not strong enough' : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),

                  SizedBox(height: 20.0),
                    
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                      onPressed: () {
                        _onRegister();
                      }
                    ),
                  ),

                  SizedBox(height: 15.0),
                    
                  Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In.',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            widget.toggleView();
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),
                    
                  Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}