import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/poll_card.dart';
import 'detail_page.dart';
import 'create_poll_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Future<List<dynamic>> fetchPolls() async {
    const String url = 'http://localhost:8080/vote'; // API URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body); // JSON 데이터를 파싱하여 반환
    } else {
      // throw Exception('Failed to load polls');
      return [
        {
          "category": "Entertainment",
          "timeAgo": "3h ago",
          "question": "Best movie of the year?",
          "options": ["Inception", "Oppenheimer"],
          "votes": 1200,
        },
        {
          "category": "Food",
          "timeAgo": "5h ago",
          "question": "What’s the ultimate comfort food?",
          "options": ["Pizza", "Burgers", "Pasta"],
          "votes": 980,
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VOTEIT'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePollPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPolls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No polls available'));
          } else {
            final polls = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: polls.length,
              itemBuilder: (context, index) {
                final poll = polls[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          category: poll['category'],
                          question: poll['question'],
                          options: List<String>.from(poll['options']),
                          votes: poll['votes'],
                        ),
                      ),
                    );
                  },
                  child: PollCard(
                    category: poll['category'],
                    timeAgo: poll['timeAgo'],
                    question: poll['question'],
                    options: List<String>.from(poll['options']),
                    votes: poll['votes'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
