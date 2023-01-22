import 'package:f1_mobile_app/calendar.dart';
import 'package:f1_mobile_app/circuits.dart';
import 'package:f1_mobile_app/news.dart';
import 'package:f1_mobile_app/standings.dart';
import 'package:flutter/material.dart';
import 'my_drawer_header.dart';

//void main() {
//runApp(MyApp());
//}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.newsPage;
  @override
  Widget build(BuildContext context) {
    var container;
    var title = "F1 mobile app";
    if (currentPage == DrawerSections.newsPage) {
      container = NewsPage();
      title = "F1 News";
    } else if (currentPage == DrawerSections.circuits) {
      container = CircuitsPage();
      title = "F1 Circuits";
    } else if (currentPage == DrawerSections.calendar) {
      container = CalendarPage();
      title = "F1 Upcoming Events";
    } else if (currentPage == DrawerSections.driverStandings) {
      container = StandingsPage();
      title = "F1 Standings - Season 2022";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xCEE10600),
        title: Text(title),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          menuItem(1, "News", Icons.newspaper,
              currentPage == DrawerSections.newsPage ? true : false),
          menuItem(2, "Circuits", Icons.circle_outlined,
              currentPage == DrawerSections.circuits ? true : false),
          menuItem(3, "Calendar", Icons.calendar_month,
              currentPage == DrawerSections.calendar ? true : false),
          menuItem(4, "Driver Standings", Icons.reorder,
              currentPage == DrawerSections.driverStandings ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              if (id == 1) {
                currentPage = DrawerSections.newsPage;
              } else if (id == 2) {
                currentPage = DrawerSections.circuits;
              } else if (id == 3) {
                currentPage = DrawerSections.calendar;
              } else if (id == 4) {
                currentPage = DrawerSections.driverStandings;
              } else if (id == 5) {
                currentPage = DrawerSections.settings;
              } else if (id == 6) {
                currentPage = DrawerSections.notifications;
              }
            });
          },
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ]))),
    );
  }
}

enum DrawerSections {
  newsPage,
  circuits,
  calendar,
  driverStandings,
  settings,
  notifications,
}
