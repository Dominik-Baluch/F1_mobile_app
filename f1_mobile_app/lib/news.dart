import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return F1NewsList();
  }
}

class F1NewsList extends StatefulWidget {
  @override
  _F1NewsListState createState() => _F1NewsListState();
}

class _F1NewsListState extends State<F1NewsList> {
  List news = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  _fetchNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=+%22formula%201%22&apiKey=2449e750bad44447b28927afd0ac5835&searchIn=title&language=en&sortBy=publishedAt"));
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body)['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(news[index]['title']),
            subtitle: Text(news[index]['description']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => F1NewsDetail(
                    news: news[index],
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

class F1NewsDetail extends StatelessWidget {
  final news;

  F1NewsDetail({this.news});

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xCEE10600),
        title: Text(news['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Image.network(news['urlToImage']),
              SizedBox(height: 16),
              Text(news['description']),
              SizedBox(height: 16),
              Text(news['content']
                  .replaceAll(new RegExp(r'\[\+\d+ chars\]'), '')),
              TextButton(
                  style:
                      TextButton.styleFrom(foregroundColor: Color(0xCEE10600)),
                  onPressed: () {
                    _launchURL(news['url']);
                  },
                  child: Text('Read more'))
            ],
          ),
        ),
      ),
    );
  }
}
