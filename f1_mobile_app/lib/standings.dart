import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StandingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return F1StandingsList();
  }
}

class F1StandingsList extends StatefulWidget {
  @override
  _F1StandingsListState createState() => _F1StandingsListState();
}

class _F1StandingsListState extends State {
  List standings = [];

  @override
  void initState() {
    super.initState();
    _fetchStandings();
  }

  _fetchStandings() async {
    var response = await http.get(
        Uri.parse(
            "https://api-formula-1.p.rapidapi.com/rankings/drivers?season=2022"),
        headers: {
          "x-rapidapi-key": "c7184e2429mshedac39fab8cedd3p123ac4jsn1f4e5fcc4d0a"
        });
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        standings = json.decode(response.body)['response'];
      });
    }
  }

  _computePositionSuffix(int pos) {
    if (pos == 11 || pos == 12 || pos == 13) {
      return "th";
    }

    if (pos % 10 == 1) {
      return "st";
    }

    if (pos % 10 == 2) {
      return "nd";
    }

    if (pos % 10 == 3) {
      return "rd";
    }

    return "th";
  }

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: standings.length,
      itemBuilder: (context, index) {
        return Card(
            child: Row(
          children: [
            Image.network(
              standings[index]["driver"]["image"],
              height: 100,
              width: 100,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                      child: Text(
                        standings[index]["position"].toString() +
                            _computePositionSuffix(
                                standings[index]["position"]) +
                            " place | " +
                            (standings[index]["points"] == null
                                    ? 0
                                    : standings[index]["points"])
                                .toString() +
                            " points",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(standings[index]["driver"]['name'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        standings[index]["team"]["name"],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ))
          ],
        ));
      },
    ));
  }
}
