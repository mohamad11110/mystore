// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:mystore/sign_up.dart';
import 'Home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController controllerusername = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  void error(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.6/mystore/login.php'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  image: AssetImage("images/login.png"),
                  width: 50,
                  height: 60,
                ),
                const Text(
                  "Login Form",
                  style: TextStyle(fontFamily: "Netflix", fontSize: 20),
                ),
                TextField(
                  controller: controllerusername,
                  style: const TextStyle(fontFamily: "Netflix"),
                  decoration: const InputDecoration(
                      hintText: "Username", labelText: "Username"),
                ),
                TextField(
                  style: const TextStyle(fontFamily: "Netflix"),
                  controller: controllerpassword,
                  obscureText: true,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                      hintText: "Password", labelText: "Password"),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if ((await login(controllerusername.value.text,
                              controllerpassword.value.text)) ==
                          'success') {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomePage();
                        }));
                      } else {
                        error(context, "Username or Password are incorrect");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontFamily: "Netflix", color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  child: const Text('Don\'t have an account? Sign up'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpForm()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// void _sendDataToSecondScreen(BuildContext context) {
//     String textToSend = controllerusername.text;
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(text: textToSend,),
//         ));
//   }
}
