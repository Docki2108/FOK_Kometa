import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../stuffs/constant.dart';

class schedule_page extends StatelessWidget {
  const schedule_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _controller = PageController();
  String textdate = '';

  @override
  void initState() {
    textdate = DateFormat('M.y').format(todaydate);
    super.initState();
  }

  var todaydate = DateTime.now();
  var tomorrowdate = DateTime.now().add(new Duration(days: 1));
  var aftertomorrowdate = DateTime.now().add(new Duration(days: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: IconButton(
              icon: const Icon(
                Icons.info_outline,
                size: 22,
              ),
              tooltip: 'Информация',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Описание групповых занятий'),
                    content: SingleChildScrollView(
                      child: const Text(
                        DESCRIPTION_OF_GROUP_TRAINING,
                      ),
                    ),
                    actions: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text(
                          'Ок',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
        elevation: 3,
        centerTitle: true,
        title: Text('Расписание на ' + textdate),
        //Text(textdate),
      ),
      body: Center(
        child: Column(
          children: [
            test1(),
            test1(),
            test1(),
            test1(),
            test1(),
          ],
        ),
      ),
    );
  }

  Widget test1() {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(12),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Text(
                            '11:00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Text(
                            textAlign: TextAlign.left,
                            '12:00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Total Body',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 7.5,
                            width: 0,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textAlign: TextAlign.left,
                                'И.И. Иванов',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16),
                              )),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  // Widget dotsview() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: ConstrainedBox(
  //       constraints: BoxConstraints(
  //         minWidth: 150,
  //         minHeight: 150,
  //         maxWidth: MediaQuery.of(context).size.width,
  //         maxHeight: MediaQuery.of(context).size.height * 0.815,
  //       ),
  //       child: PageView(
  //         controller: _controller,
  //         children: const [TodayPage(), TomorrowPage(), DayAfterPage()],
  //       ),
  //     ),
  //   );
  // }

  // Widget get dots {
  //   return ConstrainedBox(
  //     constraints: BoxConstraints(
  //         minWidth: 40, maxWidth: 100, minHeight: 20, maxHeight: 20),
  //     child: Container(
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: SmoothPageIndicator(
  //         controller: _controller,
  //         count: 3,
  //         effect: SwapEffect(
  //             activeDotColor: Colors.black,
  //             dotHeight: 10,
  //             dotWidth: 10,
  //             spacing: 10),
  //       ),
  //     ),
  //   );
  // }
}
