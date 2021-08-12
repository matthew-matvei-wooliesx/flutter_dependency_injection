import 'package:flutter/material.dart';
import 'package:flutter_dependency_injection/counters/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  void _incrementCounter() {
    context.read(counterNotifierProvider).increment();
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
              'The current count is:',
            ),
            Consumer(builder: (_, watch, __) {
              // PoC note: While it would be nice to have this dependency more
              // clearly declared, e.g. as a field of this class whose value is
              // injected through a constructor argument, the `counter` is better
              // dereferenced here from `counterNotifierProvider` rather than
              // higher in this widget's build method for performance reasons:
              // when `counterNotifierProvider` notifies of changes, only this
              // `Consumer` needs to be rebuilt, instead of unnecessarily
              // rebuilding other widgets higher up in the tree
              final counter = watch(counterNotifierProvider);
              return Text(
                  counter.count.toRadixString(10),
                  style: Theme.of(context).textTheme.headline4);
            }),
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
