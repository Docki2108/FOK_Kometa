import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/constant.dart';

import '../../../../models/service/service_model.dart';
import '../../../../stuffs/widgets.dart';

class services_page extends StatelessWidget {
  const services_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServicesPage(),
    );
  }
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<ServiceModel> services = [];
  var serviceUn;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Товары и слуги'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            if (isLoading)
              const CircularProgressIndicator()
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
