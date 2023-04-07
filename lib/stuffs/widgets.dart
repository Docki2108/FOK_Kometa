import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class NewsPost extends StatelessWidget {
  final String id_news;
  final String title;
  final String content;
  final String create_date;
  final String news_category;

  const NewsPost({
    Key? key,
    required this.id_news,
    required this.title,
    required this.content,
    required this.create_date,
    required this.news_category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Row(children: [
              Flexible(
                child: Text(
                  title,
                ),
              ),
            ]),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Center(
                    child: Flexible(
                      child: Text(
                        title + create_date,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
