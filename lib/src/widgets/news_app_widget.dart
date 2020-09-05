import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../environment.dart';
import './side_drawer_widget.dart';
import './news_grid_widget.dart';

class NewsApp extends StatefulWidget {
  State<StatefulWidget> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  String currentStream = 'Top Headlines';
  Map<String, dynamic> news = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    refreshNewsStream().then((newsData) => news = newsData);
  }

  // Callback for pull-down refresh action
  Future<Map<String, dynamic>> refreshNewsStream() async {
    var getReqUrl = '';

    if (currentStream == 'Top Headlines') {
      getReqUrl =
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=$NEWS_API_KEY';
    } else if (currentStream == 'All News') {
      getReqUrl =
          'https://newsapi.org/v2/everything?q=news&apiKey=$NEWS_API_KEY';
    }

    final getResponse = await http.get(getReqUrl);
    final newsData = convert.jsonDecode(getResponse.body);
    print(newsData);
    return newsData;
  }

  // Method passed by reference to child widget: SideDrawer, to be invoked on tag action
  // and thereby set state in the parent here.
  void setCurrentStream(String streamName) {
    setState(() => currentStream = streamName);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentStream,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshNewsStream();
        },
        child: FutureBuilder(
            future: refreshNewsStream(),
            builder: (builderContext, newsSnapshot) {
              if (newsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (newsSnapshot.hasError) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Theme.of(context).errorColor,
                      size: 22,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'Error loading news data !',
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 20,
                      ),
                    ),
                  ]),
                );
              } // end of else-if(newsSnapshot.hasError)
              else {
                return NewsGrid(
                  newsItemList: newsSnapshot.data['articles'],
                );
              }
            }),
      ),
      drawer: SideDrawer(tapAction: setCurrentStream),
    );
  }
}
