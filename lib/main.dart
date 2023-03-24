import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  final now = DateTime.now();
  var choice;
  var day;
  final List<String> days = <String>['По', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  final List<String> months = <String>['', 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Авгус', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'];
  var color = Colors.white70;

  @override
  void initState() {
    super.initState();
  }

  void _now() {
    choice = now;
  }

  void _next() {
    if (choice == null) {
      now.month == DateTime.december ?
      choice = DateTime.utc(now.year + 1, DateTime.january, 1) : choice =
          DateTime.utc(now.year, now.month + 1, 1);
    }
    else {
      choice.month == DateTime.december ?
      choice = DateTime.utc(choice.year + 1, DateTime.january, 1) : choice =
          DateTime.utc(choice.year, choice.month + 1, 1);
    }
  }

  void _previous() {
    if (choice == null) {
      now.month == DateTime.january ?
      choice = DateTime.utc(now.year - 1, DateTime.december, 1) : choice =
          DateTime.utc(now.year, now.month - 1, 1);
    }
    else {
      choice.month == DateTime.january ?
      choice = DateTime.utc(choice.year - 1, DateTime.december, 1) : choice =
          DateTime.utc(choice.year, choice.month - 1, 1);
    }
  }

  String _text(int count) {
    if (choice == null) {
      if (day == null || day == 0) {
        day =  DateTime.utc(now.year, now.month, 1);
        day.weekday == count + 1
            ? day = 1
            : day = 0;
      }
      else {
        if (now.month == DateTime.utc(now.year, now.month, day + 1).month) {
          day += 1;
        }
        else {
          day = 50;
        }
      }
    }
    else if (choice != null) {
      if (day == null || day == 0) {
        day =  DateTime.utc(choice.year, choice.month, 1);
        day.weekday == count + 1
            ? day = 1
            : day = 0;
      }
      else {
        if (choice.month == DateTime.utc(choice.year, choice.month, day + 1).month) {
          day += 1;
        }
        else {
          day = 50;
        }
      }
    }
    return day.toString();
  }

  Widget buildDayOfTheWeek (int count) {
    return Row(
        children: <Widget>[
          SizedBox(
            child: Card(
              shape: CircleBorder(),
              color: count < 5 ? color : Colors.lightBlueAccent,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                    child: Text(
                      '${days[count]}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                ),
              ),
            ),
          ),
        ]
    );
  }

  Widget buildDay(String weekend, int index) {
    return Row(
      children: <Widget>[
        day > 0 && day < 32
        ? SizedBox(
          child: Card(
            color: choice != null ? (choice.month == now.month && choice.year == now.year) ? (index <= 4 && day != now.day) ? color : day == now.day ? Colors.green : Colors.redAccent : index <= 4 ? color : Colors.redAccent : choice == null ? (index <= 4 && day != now.day) ? color : day == now.day ? Colors.green : Colors.redAccent : index <= 4 ? color : Colors.redAccent,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  weekend,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ),
            ),
          ),
        )
        : SizedBox(
          child: Card(
            elevation: 0,
            color: Colors.white10,
            child: SizedBox(
              width: 50,
              height: 50,
            ),
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Календарь"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() => {
                      day = null,
                      _previous(),
                    });
                  },
                  icon: Icon(Icons.chevron_left_outlined),
                  iconSize: 50.0,),
                TextButton(
                  onPressed: () {
                    setState(() => {
                      choice = null,
                      day = null,
                      _now()
                    });
                  },
                  child: Text(
                  choice == null
                  ?'${months[DateTime.now().month]},  ${DateTime.now().year}'
                  :'${months[choice.month]},  ${choice.year}',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => {
                      day = null,
                      _next(),
                    });
                  },
                  icon: Icon(Icons.chevron_right_outlined),
                  iconSize: 50.0,
                ),
              ]
            )
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return buildDayOfTheWeek(index);
                }),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                  return buildDay(_text(index), index);
              }),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return buildDay(_text(index), index);
                }),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return buildDay(_text(index), index);
                }),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return buildDay(_text(index), index);
                }),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return buildDay(_text(index), index);
                }),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return buildDay(_text(index), index);
                }),
          )
        ],
      )
    );
  }
}
