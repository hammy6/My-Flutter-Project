import 'dart:convert';
import 'package:curren_see/screens/Home2.dart';
import 'package:curren_see/screens/converter.dart';
import 'package:curren_see/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'converter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(

        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.34),
              child: Column(children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _handleLogin();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RegisterScreen()));
                        },
                        child: const Text(
                          'Sign Up\nagain',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5C8374),
                          ),
                        ),
                      ),
                    ]),

              ]),
            ),
          ),
        ]),
      ),
    );
  }




  Future<void> _handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    List<dynamic>? login_user;
    // Validate input
    if (email.isNotEmpty && password.isNotEmpty) {
      // TODO: Replace with your actual API endpoint
      String apiUrl = 'https://convertercurrency.000webhostapp.com/login.php';


      // Make the API request
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Registration successful
        // TODO: Implement your logic for successful Login
        // For example, show a success message, navigate to login screen, etc.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the login screen
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ScreenProduct()));
      } else {
        // Show an error message if the registration fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Login Failed. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
      // Check the status code of the response
      // if (response.statusCode == 200) {
      //   // Parse the response JSON if needed
      //   //print(response.body);
      //   // login_user = jsonDecode(response.body);
      //   // print(login_user);
      //
      //   SharedPreferences shared = await SharedPreferences.getInstance();
      //   shared.setString("login_user", response.body);
      //
      //   print(shared.getString("login_user"));
      //
      //   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home1(),));
      //   // shared.getString("login_user");
      //
      // }

    }
  }
}
