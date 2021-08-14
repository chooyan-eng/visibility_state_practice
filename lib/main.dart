import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visibitlity State Practice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Visibitlity State Practice'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _visible = true;
  var _maintainState = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('maintainState'),
                Switch(
                  value: _maintainState,
                  onChanged: (value) => setState(() {
                    _maintainState = value;
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('visibility'),
                Switch(
                  value: _visible,
                  onChanged: (value) => setState(() {
                    _visible = value;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Visibility(
              visible: _visible,
              child: const AwesomeTimer(),
              maintainState: _maintainState,
            ),
          ],
        ),
      ),
    );
  }
}

class AwesomeTimer extends StatefulWidget {
  const AwesomeTimer({Key? key}) : super(key: key);

  @override
  _AwesomeTimerState createState() => _AwesomeTimerState();
}

class _AwesomeTimerState extends State<AwesomeTimer> {
  late DateTime _startTime;
  late Timer _timer;

  var _millisecPassed = 0;

  String get _displayTime {
    final millisec = _millisecPassed % 1000 ~/ 100;
    final seconds =
        ((_millisecPassed / 1000) % 60).toInt().toString().padLeft(2, '0');
    final mins =
        (_millisecPassed / 1000 / 60).toInt().toString().padLeft(2, '0');

    return '$mins:$seconds.$millisec';
  }

  @override
  void initState() {
    _startTime = DateTime.now();

    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => _tick(),
    );

    super.initState();
  }

  void _tick() {
    setState(() {
      _millisecPassed = DateTime.now().difference(_startTime).inMilliseconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 2),
      ),
      child: Text(
        _displayTime,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
