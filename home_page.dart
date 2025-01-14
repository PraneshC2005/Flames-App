import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  String result = "";

  void logic() {
    String firstName = firstNameController.text.trim().toLowerCase();
    String secondName = secondNameController.text.trim().toLowerCase();

    if (firstName.isEmpty || secondName.isEmpty) {
      setState(() {
        result = "Please enter both names!";
      });
      return;
    }

    // Remove common characters
    for (int i = 0; i < firstName.length; i++) {
      if (secondName.contains(firstName[i])) {
        secondName = secondName.replaceFirst(firstName[i], '');
        firstName = firstName.replaceFirst(firstName[i], '');
        i = -1; // Restart the loop since strings have changed
      }
    }

    int count = firstName.length + secondName.length;

    // FLAMES Logic
    List<String> flames = ["Friends", "Love", "Affection", "Marriage", "Enemy", "Sibling"];
    while (flames.length > 1) {
      int index = (count % flames.length) - 1;
      if (index >= 0) {
        flames = flames.sublist(index + 1) + flames.sublist(0, index);
      } else {
        flames.removeLast();
      }
    }

    setState(() {
      result = "Your relationship is: ${flames.first}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flames"),
        backgroundColor: Colors.green,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Name:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Second Name:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: secondNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: logic,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Check Relationship",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                result,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
