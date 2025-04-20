import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String category;
  final String question;
  final List<String> options;
  final int votes;

  const DetailPage({
    super.key,
    required this.category,
    required this.question,
    required this.options,
    required this.votes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            const SizedBox(height: 16.0),
            Text(
              '$votes votes - Results visible',
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.comment),
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
