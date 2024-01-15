import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'List_Data.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  const EditData({super.key, required this.list, required this.index});

  @override
  // ignore: library_private_types_in_public_api
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName= TextEditingController();
  TextEditingController controllerPrice= TextEditingController();
  TextEditingController controllerStock= TextEditingController();

 void editData() {
  var url = Uri.parse("http://192.168.1.6/mystore/Edit_data.php");
  http.post(url, body: {
    "id": widget.list[widget.index]['id'],
    "itemcode": controllerCode.text,
    "itemname": controllerName.text,
    "price": controllerPrice.text,
    "stock": controllerStock.text
  }).then((response) {
    if (response.statusCode == 200) {
      print('Data updated successfully');
    } else {
      print('Failed to update data');
    }
  });
}
  @override
  void initState() {
    controllerCode =
        TextEditingController(text: widget.list[widget.index]['item_code']);
    controllerName =
        TextEditingController(text: widget.list[widget.index]['item_name']);
    controllerPrice =
        TextEditingController(text: widget.list[widget.index]['price']);
    controllerStock =
        TextEditingController(text: widget.list[widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Data",
          style: TextStyle(fontFamily: "Netflix"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerCode,
                  style: const TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: const InputDecoration(
                      hintText: "Item Code", labelText: "Item Code"),
                ),
                TextField(
                  controller: controllerName,
                  style: const TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: const InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                TextField(
                  controller: controllerPrice,
                  style: const TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: const InputDecoration(
                      hintText: "Price", labelText: "Price"),
                ),
                TextField(
                  controller: controllerStock,
                  style: const TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: const InputDecoration(
                      hintText: "Stock", labelText: "Stock"),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {
                      editData();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const ListData()));
                    },
                    child: const Text(
                      "EDIT DATA",
                      style:
                          TextStyle(fontFamily: "Netflix", color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const ListData();
                    }));
                  },
                  child: const Text("Back to menu", style: TextStyle(fontFamily: "Netflix", color: Colors.white),),
                ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
