import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/graphql.dart';
import 'package:graphql/client.dart';

import '../../../models/diet/diet_model.dart';
import '../../../stuffs/constant.dart';
import '../../../stuffs/widgets.dart';

class DietsPage extends StatefulWidget {
  const DietsPage({super.key});

  @override
  State<DietsPage> createState() => _DietsPageState();
}

class _DietsPageState extends State<DietsPage> {
  List<DietModel> diets = [];
  bool isLoading = true;
  @override
  void initState() {
    GRaphQLProvider.client
        .query(
      QueryOptions(
        document: gql(dietHelp),
      ),
    )
        .then((value) {
      var dietsUn = value;
      var dietList =
          ((dietsUn.data as Map<String, dynamic>)['diet'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      diets = dietList.map((e) => DietModel.fromMap(e)).toList();
    });
    setState(() {
      isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('Диеты'),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                'Подборка лучших диет',
                style: TextStyle(
                  fontSize: 24,
                  //color: Colors.black,
                ),
              ),
            ),
            Divider(),
            if (isLoading)
              CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: diets.length,
                  itemBuilder: (context, i) {
                    return DietPost(
                      id_diet: '${diets[i].id}',
                      name: '${diets[i].name}',
                      duration: '${diets[i].duration}',
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
