import 'dart:async';
import 'dart:convert';
import 'package:logging/logging.dart'; // Import a logging package
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Delete_data.dart';
import 'add_data.dart';
import 'Home_page.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  // final String text;
  // Home({Key key, @required this.text}) : super(key: key);
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  final Logger _logger = Logger('Home');

  Future<List> getData() async {
  http.Response response = await http.get(Uri.parse("http://192.168.1.6/mystore/Get_data.php"));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return json.decode(response.body);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Data Inventory",
          style: TextStyle(fontFamily: "Netflix"),
        ),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "logout",
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
            },
            label: const Text('Menu'),
            icon: const Icon(Icons.logout),
            backgroundColor: Colors.blue,
          ),
          const SizedBox(
            width: 20,
          ),
          //SizedBox(height: 10,),
          FloatingActionButton.extended(
            heroTag: "Add data",
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const AddData()));
            },
            label: const Text('Add Data'),
            icon: const Icon(Icons.add_box),
            backgroundColor: Colors.pink,
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) _logger.severe(snapshot.error);

          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data ?? [],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Detail(
                          list: list,
                          index: i,
                        ))),
            child: Card(
              child: ListTile(
                title: Text(
                  list[i]['item_name'],
                  style: const TextStyle(fontFamily: "Netflix"),
                ),
                leading: const Icon(Icons.widgets),
                subtitle: Text("Stock : ${list[i]['stock']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
