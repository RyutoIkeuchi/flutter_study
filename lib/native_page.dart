import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final batteryProvider = ChangeNotifierProvider((ref) => BatteryModel());

class BatteryModel extends ChangeNotifier {
  String batteryLevel = "バッテリーのパーセンテージ";

  MethodChannel _channel = MethodChannel('sample.flutter.dev');

  Future<void> getBatteryLevel() async {
    try {
      final result = await _channel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result%.';
      notifyListeners();
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
      notifyListeners();
    }
  }
}

class NativePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ネイティブコードを呼び出した'),
      ),
      body: Center(child: Consumer(builder: (context, watch, build) {
        final batteryLevel = watch(batteryProvider).batteryLevel;
        return Text(batteryLevel);
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read(batteryProvider).getBatteryLevel,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
