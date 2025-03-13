import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.seek.flutter');
  String nativeMessage = "Press the button to get data from iOS";

Future<void> _getNativeData() async {
  try {
    print("Invocando el método getData en el canal...");
    final String result = await platform.invokeMethod('getData');
    setState(() {
      nativeMessage = result;
    });
    print("Respuesta recibida de iOS: $result");
  } on PlatformException catch (e) {
    setState(() {
      nativeMessage = "Failed to get data: '${e.message}'.";
    });
    print("Error en el canal: ${e.message}");
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Module')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nativeMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getNativeData,
                child: Text('Call Native Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}