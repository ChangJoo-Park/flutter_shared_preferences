import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistence Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SharedPreferences Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SharedPreferences prefs;

  /// 카운터를 1 증가한다.
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    setPersistenceCounter(_counter);
  }

  /// 카운터를 초기화한다.
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    setPersistenceCounter(_counter);
  }

  /// counter를 앱에 저장한다.
  void setPersistenceCounter(int counter) async {
    if (prefs == null) {
      _initializeCounter();
    }
    print('hello world');
    prefs.setInt('counter', counter);
  }

  /// [_counter]를 SharedPreferences에서 가져와 초기화한다.
  ///
  /// 없으면 0으로 초기화한다.
  void _initializeCounter() async {
    prefs = await SharedPreferences.getInstance();
    int persistenceCounter = prefs.getInt('counter') ?? 0;

    setState(() {
      _counter = persistenceCounter;
    });
  }

  @override
  void initState() {
    _initializeCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _resetCounter,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
