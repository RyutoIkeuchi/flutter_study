import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countUpProvider = ChangeNotifierProvider((ref) => CountModel(),);

class CountModel extends ChangeNotifier {
  int count = 0;

  void incrementCounter() {
    count += 1;
    notifyListeners();
  }
}

class CountUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('riverpod使った'),
      ),
      body: Center(child: Consumer(builder: (context, watch, build) {
        final _counter = watch(countUpProvider).count;
        return Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        );
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read(countUpProvider).incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
