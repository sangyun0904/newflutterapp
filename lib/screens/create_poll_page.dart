import 'package:flutter/material.dart';

class CreatePollPage extends StatefulWidget {
  const CreatePollPage({super.key});

  @override
  _CreatePollPageState createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  String selectedCategory = 'Entertainment'; // 기본 카테고리
  final List<String> categories = [
    'Entertainment',
    'Food',
    'Travel',
    'Lifestyle'
  ];

  void addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  void removeOption(int index) {
    setState(() {
      if (optionControllers.length > 2) {
        optionControllers.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Poll'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Question',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your question here',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Options',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: optionControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: optionControllers[index],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Option ${index + 1}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      if (optionControllers.length > 2)
                        IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () {
                            removeOption(index);
                          },
                        ),
                    ],
                  );
                },
              ),
            ),
            TextButton.icon(
              onPressed: addOption,
              icon: const Icon(Icons.add),
              label: const Text('Add Option'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final question = questionController.text;
                final options = optionControllers
                    .map((controller) => controller.text)
                    .toList();

                if (question.isNotEmpty &&
                    options.every((option) => option.isNotEmpty)) {
                  // TODO: Handle poll creation logic
                  print('Category: $selectedCategory');
                  print('Question: $question');
                  print('Options: $options');

                  // Navigate back to the main page
                  Navigator.pop(context);
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Create Poll'),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
