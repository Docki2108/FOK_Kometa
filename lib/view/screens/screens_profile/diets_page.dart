import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/graphql.dart';
import 'package:graphql/client.dart';

import '../../../models/diet/diet_model.dart';
import '../../../stuffs/constant.dart';

class DietsPage extends StatefulWidget {
  const DietsPage({super.key});

  @override
  State<DietsPage> createState() => _DietsPageState();
}

class _DietsPageState extends State<DietsPage> {
  List<DietModel> diets = [];

  @override
  void initState() {
    GRaphQLProvider.client
        .query(
      QueryOptions(
        document: gql(getAllDietsData),
      ),
    )
        .then((value) {
      var dietsUn = value;
      var dietList =
          ((dietsUn.data as Map<String, dynamic>)['diet'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      diets = dietList.map((e) => DietModel.fromMap(e)).toList();
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
        child: Column(),
      ),
    );
  }
}
