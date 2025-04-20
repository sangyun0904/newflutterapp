import 'package:flutter/material.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          PollCard(
            category: 'Entertainment',
            timeAgo: '3h ago',
            question: 'Best movie of the year?',
            options: ['Inception', 'Oppenheimer'],
            votes: 1200,
          ),
          PollCard(
            category: 'Food',
            timeAgo: '5h ago',
            question: 'What’s the ultimate comfort food?',
            options: ['Pizza', 'Burgers', 'Pasta'],
            votes: 980,
          ),
          PollCard(
            category: 'Travel',
            timeAgo: '12h ago',
            question: 'Which city should I visit?',
            options: ['Tokyo', 'New York'],
            votes: 754,
          ),
          PollCard(
            category: 'Lifestyle',
            timeAgo: '1d ago',
            question: 'How do you prefer to exercise?',
            options: ['Gym', 'Running', 'Yoga'],
            votes: 2100,
          ),
        ],
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
