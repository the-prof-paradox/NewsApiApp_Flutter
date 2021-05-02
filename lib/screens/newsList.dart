import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/model/jsonParsing.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/screens/newsArticle.dart';

class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  var apiURL = Uri.parse('https://hubblesite.org/api/v3/news');
  List<News> _newsList = [];

  getNews() async {
    // var client = http.Client();
    var response = await http.get(apiURL);
    if (response.statusCode == 200) {
      var jsonMap = json.decode(response.body);
      print(jsonMap.length);
      setState(() {
        for (int i = 0; i < jsonMap.length; i++) {
          _newsList.add(News.fromJson(jsonMap[i]));
        }
      });
      print(_newsList.length);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getNews();
  }

  @override
  Widget build(BuildContext context) {
    if (_newsList.length > 0) {
      return ListView.builder(
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            News news = _newsList[index];
            return Column(
              children: [
                ListTile(
                  title: Text(
                    news.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewExample(
                            url: news.url,
                          ),
                        ));
                  },
                ),
                Divider(
                  color: Colors.blueGrey,
                ),
              ],
            );
          });
    }
    return Center(
      child: Image.asset('assets/Loading.gif'),
    );
  }
}
