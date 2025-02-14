import 'package:flutter/material.dart';
import 'api_service.dart';
import 'registration_page.dart';
import 'thread.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostRequestDemo(),
    );
  }
}
class PostRequestDemo extends StatefulWidget {
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  _PostRequestDemoState createState() => new _PostRequestDemoState();
}

class _PostRequestDemoState extends State<PostRequestDemo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFD9D9D9),
        title: Text("ログイン"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: widget.nameController,
              decoration: InputDecoration(labelText: '名前'),
            ),
            TextField(
              controller: widget.passwordController,
              decoration: InputDecoration(labelText: 'パスワード'),
              obscureText: true, // パスワード入力を隠す
            ),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.all(35)
            ),
            if (widget._errorMessage.isNotEmpty) // エラーがあるときだけ表示
              Text(
                widget._errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
        SizedBox(
          width: 200,
          height: 80,
            child:
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFD9D9D9)),
              ),
              onPressed: () async {
                String username = widget.nameController.text;
                String password = widget.passwordController.text;
                print("ログイン");
                if (username.isNotEmpty && password.isNotEmpty) {
                  try {
                    String data = "grant_type=password&username=${username}&password=${password}&scope=&client_id=&client_secret=";
                    final response = await widget.apiService.sendGetTokenRequest(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Response: ${response.toString()}')),
                    );
                    Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ThreadPage()));


                } catch (e) {
                    setState(() {
                      widget._errorMessage="ユーザー名かパスワードが間違っています";
                    });
                    print("errer:${e}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('errer${e}')),
                    );
                  }
                  // await authenticateUser(context, name, password);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('全てのフィールドを入力してください。')),
                  );
                }
              },
              child: Text(
                "ログイン",
                style: TextStyle(
                  fontSize: 25,
                  color:Color(0xFF000000),
                ),
              ),
            ),
        ),
          Padding(
            padding: EdgeInsets.all(25)
          ),
        SizedBox(
          width: 200,
          height: 80,// 幅を調整
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFD9D9D9)),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text(
                "初回登録",
                style: TextStyle(
                  fontSize: 25,
                  color:Color(0xFF000000),
                ),
              ),
            ),
        )
          ],
        ),
      ),
    );
  }
}
