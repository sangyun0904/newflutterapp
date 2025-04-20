import 'package:flutter/material.dart';

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
            Text(
              question,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
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
