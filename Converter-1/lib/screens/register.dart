import 'dart:convert';
import 'package:curren_see/screens/Home2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/reg.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
         backgroundColor: Colors.transparent,
          body: Stack(children: [
            Positioned(
              top: -15,
              child: Container(
                padding: const EdgeInsets.only(left: 35, top: 80,),
                child: const Text(
                  "Create\nAccount",

                  style: TextStyle(color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.27),


                child: Column(children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _handleRegistration();
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Color(0xFF5C8374),
                            ),
                          ),
                        ),

                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(
                           onPressed: () {
                             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                           },
                           child: const Text(
                             'Login',
                             style: TextStyle(
                               fontSize: 20,
                               color: Colors.white,
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



  Future<void> _handleRegistration() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validate input
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // TODO: Replace with your actual API endpoint
      String apiUrl = 'https://convertercurrency.000webhostapp.com/register.php';

      try {
        // Make the API request
        final response = await http.post(
          Uri.parse(apiUrl),

          body: {
            'username': username,
            'email': email,
            'password': password,
          },
        );

        // Check the status code of the response
        if (response.statusCode == 200) {
          // Registration successful
          // TODO: Implement your logic for successful registration
          // For example, show a success message, navigate to login screen, etc.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration Successful'),
              duration: Duration(seconds: 2),
            ),
          );

          // Navigate to the login screen
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
        } else {
          // Show an error message if the registration fails
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Registration failed. Please try again.'),
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
      } catch (error) {
        // Handle network errors or other exceptions
        print('Error: $error');
      }
    } else {
      // Show an error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields.'),
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
  }
}
