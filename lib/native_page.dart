import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final nativePageProvider = ChangeNotifierProvider((ref) => NativePageModel());

class NativePageModel extends ChangeNotifier {
  String pageLevel = 'Swiftで作った画面を表示させてみる';
  MethodChannel _channel = MethodChannel('sample.flutter.dev');

  Future<void> getViewController() async {
    try {
      await _channel.invokeMethod('getViewController');
      notifyListeners();
    } on PlatformException {
      pageLevel = 'Failed to get ViewController level.';
      notifyListeners();
    }
  }
}

class NativePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('swiftで作った画面'),
      ),
      body: Center(child: Consumer(builder: (context, watch, build) {
        final pageLevel = watch(nativePageProvider).pageLevel;
        return Text(pageLevel);
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read(nativePageProvider).getViewController,
        tooltip: 'navigation',
        child: Icon(Icons.navigate_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
