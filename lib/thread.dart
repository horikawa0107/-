import 'package:flutter/material.dart';
import 'api_service.dart'; // APIを利用するためにインポート

class ThreadPage extends StatefulWidget {
  @override
  _ThreadPageState createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  String _message = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchHelloMessage();
  }

  Future<void> fetchHelloMessage() async {
    try {
      String message = await helloRequester();
      if (message == "errer") {
        showErrorDialog();
      } else {
        setState(() {
          _message = message;
        });
      }
    } catch (error) {
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("認証に失敗しました。再ログインをお願いします。"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    ).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9C68F),
      appBar: AppBar(
        backgroundColor: Color(0xFFD9C68F),
        title: Text("thread"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 100,
              child: Text(
                "threadページ",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: Text(
                _message, // API の結果を表示
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}