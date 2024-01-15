import 'package:flutter/material.dart';
import 'Edit_data.dart';
import 'package:http/http.dart' as http;
import 'List_Data.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({super.key, required this.index, required this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
   var url = Uri.parse("http://192.168.1.6/mystore/Delete_data.php");
    http.post(url, body: {'id': widget.list[widget.index]['id']});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const ListData();
    }));
    _DeleteData(context, "Data deleted successfuly");
  }

  void _DeleteData(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "${widget.list[widget.index]['item_name']}",
        style: const TextStyle(fontFamily: "Netflix"),
      )),
      body: Container(
        height: 370.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                  widget.list[widget.index]['item_name'],
                  style: const TextStyle(fontFamily: "Netflix", fontSize: 20.0),
                ),
                Text(
                  "Code : ${widget.list[widget.index]['item_code']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Price : Rp. ${widget.list[widget.index]['price']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Stock : ${widget.list[widget.index]['stock']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                
                Column(
                   children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),

                        onPressed: () => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => EditData(
                            list: widget.list,
                            index: widget.index,
                          ),
                        )),
                        child: const Text(
                          "EDIT",
                          style: TextStyle(
                              fontFamily: "Netflix", color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
                        onPressed: () => deleteData(),
                        child: const Text(
                          "DELETE",
                          style: TextStyle(
                              fontFamily: "Netflix", color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                // new Padding(
                //   padding: const EdgeInsets.only(top: 30.0),
                // ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const ListData();
                      }));
                    },
                    child: const Text(
                      "Return",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
