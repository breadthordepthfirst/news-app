import 'package:flutter/material.dart';
import './news_grid_item.dart';

class NewsGrid extends StatelessWidget {
  final List<dynamic> newsItemList;

  NewsGrid({@required this.newsItemList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400, // Max. extent of single grid-item

          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          childAspectRatio: 1.7/2.3,
        ),
        itemCount: newsItemList.length,
        itemBuilder: (builderContext, articleIdx) {
          final newsArticle = newsItemList[articleIdx];

          print(
              'Author: ${newsArticle['author']}, Description: ${newsArticle['description']}, imageUrl: ${newsArticle['urlToImage']}, publishedAt: ${newsArticle['publishedAt']}, sourceName: ${newsArticle['source']['name']}, title: ${newsArticle['title']}');

          return NewsGridItem(
            author: newsArticle['author'],
            description: newsArticle['description'] ?? newsArticle['content'],
            imageUrl: newsArticle['urlToImage'],
            publishedAt: newsArticle['publishedAt'],
            sourceName: newsArticle['source']['name'],
            title: newsArticle['title'],
          );
        });
  }
}
