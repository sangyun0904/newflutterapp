import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoteIt',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Future<List<dynamic>> fetchPolls() async {
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
      {
        "category": "Travel",
        "timeAgo": "12h ago",
        "question": "Which city should I visit?",
        "options": ["Tokyo", "New York"],
        "votes": 754,
      },
      {
        "category": "Lifestyle",
        "timeAgo": "1d ago",
        "question": "How do you prefer to exercise?",
        "options": ["Gym", "Running", "Yoga"],
        "votes": 2100,
      },
    ];
    // const String url = 'http://localhost:8080/api/v1/vote'; // API URL
    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   return json.decode(response.body); // JSON 데이터를 파싱하여 반환
    // } else {
    //   throw Exception('Failed to load polls');
    // }
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
              // Add new poll action
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
                return PollCard(
                  category: poll['category'],
                  timeAgo: poll['timeAgo'],
                  question: poll['question'],
                  options: List<String>.from(poll['options']),
                  votes: poll['votes'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PollCard extends StatelessWidget {
  final String category;
  final String timeAgo;
  final String question;
  final List<String> options;
  final int votes;

  const PollCard({
    super.key,
    required this.category,
    required this.timeAgo,
    required this.question,
    required this.options,
    required this.votes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  timeAgo,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              question,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Column(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.5, // Example progress value
                          backgroundColor: Colors.grey.shade300,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(option),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12.0),
            Text(
              '$votes votes',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
