import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';

class win_clients_page extends StatelessWidget {
  const win_clients_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinClientsPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinClientsPage extends StatefulWidget {
  @override
  _WinClientsPageState createState() => _WinClientsPageState();
}

class _WinClientsPageState extends State<WinClientsPage> {
  List<dynamic> clients = [];

  @override
  void initState() {
    super.initState();
    fetchClients();
  }

  Future<void> fetchClients() async {
    try {
      final response = await Dio().get('http://localhost:5000/clients');
      if (response.data != null) {
        setState(() {
          clients = List.from(response.data);
        });
      }
    } catch (e) {
      throw Exception('Failed to fetch clients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Клиенты'),
        centerTitle: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey[100],
              child: clients.isEmpty
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: clients.length,
                      itemBuilder: (BuildContext context, int index) {
                        final client = clients[index];
                        final personalData = client['personal_data'];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            elevation: 3.0,
                            child: ListTile(
                              title: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                client['email'] ?? 'Нет данных',
                                                style: const TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 154, 185, 201),
                                                    fontSize: 22),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    personalData['Second_name'] ??
                                        'Нет фамилии',
                                    style: const TextStyle(fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    personalData['First_name'] ?? 'Нет имени',
                                    style: const TextStyle(fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    personalData['Patronymic'] ??
                                        'Нет отчества',
                                    style: const TextStyle(fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    personalData['Mobile_number'] ??
                                        'Нет номера телефона',
                                    style: const TextStyle(fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
