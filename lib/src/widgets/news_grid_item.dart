import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

//import '../../assets/images/news.png';

class NewsGridItem extends StatelessWidget {
  final String newsItemUrl;
  final String imageUrl;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String publishedAt;

  NewsGridItem({
    @required this.newsItemUrl,
    @required this.imageUrl,
    @required this.sourceName,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.publishedAt,
  });

  // Callback to launch a news item in the default external browser
  // on the device.
  Future<void> _openNewsItem(BuildContext widgetContext) async {
    if (await canLaunch(newsItemUrl)) {
      await launch(newsItemUrl);
    } else {
      Scaffold.of(widgetContext).hideCurrentSnackBar();
      Scaffold.of(widgetContext).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                color: Theme.of(widgetContext).errorColor,
                size: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Error opening item : ${(title.length > 20) ? title.substring(0, 20) : title}',
                style: TextStyle(
                  color: Theme.of(widgetContext).errorColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          duration: Duration(
            seconds: 3,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Published at ${DateFormat.yMMMd('en-US').format(DateTime.parse(publishedAt.trim())).toString()}');

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => _openNewsItem(context),
      splashColor: Colors.purple,
      child: Card(
        elevation: 5,
        shadowColor: Colors.purple[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width > 500 ? 190 : 230,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.blueGrey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: ClipRRect(
                child: (imageUrl == null)
                    ? Image.asset(
                        'assets/images/news.png',
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (author != null)
                          Text(
                            author,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width > 500
                                  ? 15
                                  : 17,
                            ),
                          ),
                        if (publishedAt != null)
                          Text(
                            // publishedAt,
                            DateFormat.yMMMd('en-US')
                                .format(DateTime.parse(publishedAt.trim()))
                                .toString(),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width > 500
                                  ? 15
                                  : 17,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      sourceName ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.of(context).size.width > 500 ? 15 : 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                (title == null)
                    ? ''
                    : (title.length >
                            (MediaQuery.of(context).size.width > 500
                                ? 110
                                : 150))
                        ? title.substring(
                                0,
                                (MediaQuery.of(context).size.width > 500
                                    ? 110
                                    : 150)) +
                            '...'
                        : title,
                textAlign: TextAlign.start,
                style: MediaQuery.of(context).size.width > 500
                    ? Theme.of(context).textTheme.headline6
                    : Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Text(
                (description == null)
                    ? ''
                    : (description.length >
                            (MediaQuery.of(context).size.width > 500
                                ? 100
                                : 150))
                        ? description.substring(
                                0,
                                (MediaQuery.of(context).size.width > 500
                                    ? 100
                                    : 150)) +
                            '...'
                        : description,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 500 ? 16 : 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
