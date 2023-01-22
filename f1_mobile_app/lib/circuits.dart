import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class CircuitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return F1CircuitsList();
  }
}

class F1CircuitsList extends StatefulWidget {
  @override
  _F1CircuitsListState createState() => _F1CircuitsListState();
}

class _F1CircuitsListState extends State {
  List circuits = [];

  @override
  void initState() {
    super.initState();
    _fetchCircuits();
  }

  _fetchCircuits() async {
    var response = await http.get(
        Uri.parse("https://api-formula-1.p.rapidapi.com/circuits"),
        headers: {
          "x-rapidapi-key": "c7184e2429mshedac39fab8cedd3p123ac4jsn1f4e5fcc4d0a"
        });
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        circuits = json.decode(response.body)['response'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: circuits.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(circuits[index]['name']),
            subtitle: Text(circuits[index]['competition']["location"]["city"] +
                ", " +
                circuits[index]['competition']["location"]["country"]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => F1CircuitsDetail(
                    circuits: circuits[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }
}

class F1CircuitsDetail extends StatelessWidget {
  final circuits;

  F1CircuitsDetail({this.circuits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xCEE10600),
        title: Text(circuits['name']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Image.network(circuits['image']),
              ),
              SizedBox(height: 16),
              Text(
                  "Country: " + circuits['competition']['location']['country']),
              Text("City " + circuits['competition']['location']['city']),
              Text("Capacity: " + circuits['capacity'].toString()),
              Text("Length " + circuits['length']),
            ],
          ),
        ),
      ),
    );
  }
}
