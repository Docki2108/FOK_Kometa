import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/constant.dart';
import 'package:graphql/client.dart';

import '../../models/service/service_model.dart';
import '../../stuffs/graphql.dart';
import '../../stuffs/widgets.dart';

class services_page extends StatelessWidget {
  const services_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ServicesPage(),
    );
  }
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late QueryOptions currentQuery;

  List<ServiceModel> services = [];
  var serviceUn;

  bool isLoading = true;

  @override
  void initState() {
    GRaphQLProvider.client
        .query(
      QueryOptions(
        document: gql(allService),
      ),
    )
        .then((value) {
      serviceUn = value;
      var newsList =
          ((serviceUn.data as Map<String, dynamic>)['service'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      services = newsList.map((e) => ServiceModel.fromMap(e)).toList();

      setState(() {
        isLoading = false;
      });
    });

    currentQuery = QueryOptions(
      document: gql(allService),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Text('Услуги'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                'Наши товары и услуги',
                style: TextStyle(
                  fontSize: 32,
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
                  itemCount: services.length,
                  itemBuilder: (context, i) {
                    return ServicePost(
                        id_service: '${services[i].id_service}',
                        name: '${services[i].name}',
                        cost: '${services[i].cost}',
                        description: '${services[i].description}',
                        service_category:
                            '${services[i].service_category.name}');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
