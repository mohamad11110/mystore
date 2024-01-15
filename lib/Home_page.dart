
import 'package:flutter/material.dart';
import 'package:mystore/Login_Form.dart';
import 'List_Data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // final String text;
  // HomePage({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Homepage"),),
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Image(image: AssetImage("images/dashboard.png"),width: 50,height: 60,),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
            width: double.infinity,
            child: Text(
              "Hello, admin",
              style: TextStyle(fontFamily: "Netflix", fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) => Colors.blueAccent)
                ),
                child: const Text(
                  "View Data",
                  style: TextStyle(fontFamily: "Netflix", color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const ListData();
                  }));
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) => Colors.blueAccent)),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontFamily: "Netflix", color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginForm();
                  }));
                  logout(context);
                }),
          ),
        ],
      ),
    ));
  }
}

void logout(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text("You have successfully logged out!"),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
