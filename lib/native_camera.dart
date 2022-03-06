import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final cameraProvider = ChangeNotifierProvider((ref) => CameraModel());

class CameraModel extends ChangeNotifier {
  String cameraLevel = 'カメラ起動させるよ〜';
  MethodChannel _channel = MethodChannel('sample.flutter.dev');

  Future<void> getCamera() async {
    try {
      await _channel.invokeMethod('getCamera');
      notifyListeners();
    } on PlatformException {
      cameraLevel = 'Failed to get battery level.';
      notifyListeners();
    }
  }
}

class NativeCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('swiftからカメラを起動させた'),
      ),
      body: Center(child: Consumer(builder: (context, watch, build) {
        final cameraLevel = watch(cameraProvider).cameraLevel;
        return Text(cameraLevel);
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read(cameraProvider).getCamera,
        tooltip: 'Increment',
        child: Icon(Icons.camera),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
