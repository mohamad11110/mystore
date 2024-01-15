// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mystore/Login_Form.dart'; // Import the http package

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController controllerusername = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  Future<String> signUp(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.6/mystore/Sign_up.php'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(children: <Widget>[
          SizedBox(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controllerusername,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: controllerpassword,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)) ,
                    child: const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontFamily: "Netflix", color: Colors.white),
                    ),
                    onPressed: () async {
                      final result = await signUp(
                          controllerusername.text, controllerpassword.text);
                      if (result == 'success') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content:
                                  const Text('Account created successfully!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginForm()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Failed to create account.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
