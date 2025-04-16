import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http; // HTTP 패키지 추가

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _controller =
      TextEditingController(); // TextEditingController 추가

  Future<void> _sendDataToServer(String text) async {
    const String url = 'http://localhost:8080/gomin'; // 백엔드 서버 URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: '{"text": "$text"}', // JSON 형식으로 데이터 전송
      );

      if (response.statusCode == 200) {
        print('Data sent successfully: ${response.body}');
      } else {
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('A random idea:'),
            Text(appState.current.asLowerCase),
            SizedBox(height: 20),
            Text('Enter your thoughts:'),
            TextField(
              maxLines: null, // Allows for multi-line input
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type something here...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text;
                if (text.isNotEmpty) {
                  _sendDataToServer(text); // 서버로 데이터 전송
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
