import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

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
  String successMsg = '';

  void askPermission() {
    PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  void downloadFile() async {
    var beginTimer = new DateTime.now();
    askPermission();

    String url = 'https://devdactic.com/html/5-simple-hacks-LBT.pdf';

    final dir = await getExternalStorageDirectory();
    String path = dir.path + '/Download/';

    await new Dio().download(url, path + 'downloadFlutter.pdf');

    var endTimer = new DateTime.now();
    String duration = endTimer.difference(beginTimer).inMilliseconds.toString();
    setState(() {
      successMsg = 'Download finished in ' + duration + 'ms';
    });
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
            Text(successMsg),
            RaisedButton(
              onPressed: downloadFile,
              child: Text('Download File'),
            ),
          ],
        ),
      ),
    );
  }
}
