import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/constant.dart';
import '../../../../models/diet/diet_model.dart';
import '../../../../stuffs/widgets.dart';

class DietsPage extends StatefulWidget {
  const DietsPage({super.key});

  @override
  State<DietsPage> createState() => _DietsPageState();
}

class _DietsPageState extends State<DietsPage> {
  List<DietModel> diets = [];
  bool isLoading = true;

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
            if (isLoading)
              const CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: diets.length,
                  itemBuilder: (context, i) {
                    return DietPost(
                      id_diet: '${diets[i].id}',
                      name: diets[i].name,
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
