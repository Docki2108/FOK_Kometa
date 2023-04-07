import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/view/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hasura_connect/hasura_connect.dart';
import '../../models/news/news_model.dart';
import '../../stuffs/constant.dart';
import '../../stuffs/graphql.dart';
import '../../stuffs/widgets.dart';

class first_page extends StatelessWidget {
  first_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);
  HasuraConnect hasuraConnect = HasuraConnect(GRAPHQL_LINK);
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late TextEditingController searchController;
  late StreamController<String> searchStream;
  late QueryOptions currentQuery;

  List<NewsModel> news = [];
  var newsUn;

  @override
  void initState() {
    GRaphQLProvider.client
        .query(
      QueryOptions(
        document: gql(allNews),
      ),
    )
        .then((value) {
      newsUn = value;
      var newsList =
          ((newsUn.data as Map<String, dynamic>)['news'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      news = newsList.map((e) => NewsModel.fromMap(e)).toList();
    });

    currentQuery = QueryOptions(
      document: gql(newsView),
    );

    super.initState();
  }

  // @override
  // void initState() {
  //   currentQuery = QueryOptions(
  //       document: gql(newsSearch),
  //       fetchPolicy: FetchPolicy.networkOnly,
  //       variables: {"_like": "%%"});
  //   searchController = TextEditingController();
  //   searchStream = StreamController<String>();
  //   searchController.addListener(() {
  //     searchStream.add(searchController.text);
  //   });
  //   searchStream.stream.debounceTime(Duration(seconds: 1)).listen((event) {
  //     setState(() {
  //       currentQuery = QueryOptions(
  //           document: gql(newsSearch),
  //           fetchPolicy: FetchPolicy.networkOnly,
  //           variables: {"_like": "%$event%"});
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Supabase.instance.client.auth.currentUser == null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Выйти',
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed(login_page.route);
                })
            : null,
        centerTitle: true,
        elevation: 3,
        title: const Center(
          child: Text('Главная'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                'Новости',
                style: TextStyle(
                  fontSize: 32,
                  //color: Colors.black,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future: GRaphQLProvider.client.query(
                  currentQuery,
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ]),
                    );
                  } else {
                    //  log(snapshot.data.toString());
                    var newsList = ((newsUn.data
                            as Map<String, dynamic>)['news'] as List<dynamic>)
                        .cast<Map<String, dynamic>>();
                    return ListView.builder(
                      itemCount: newsList.length,
                      itemBuilder: (context, i) {
                        return NewsPost(
                            id_news: '${newsList[i]['id_news']}',
                            content: '${newsList[i]['content']}',
                            title: '${newsList[i]['title']}',
                            create_date: '${newsList[i]['create_date']}',
                            news_category: '${newsList[i]['news_category']}');
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
