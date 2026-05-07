import 'package:flutter/material.dart';

class ProducerHome extends StatelessWidget {
  const ProducerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Producer Dashboard"),
      ),
      body: const Center(
        child: Text(
          "Welcome Producer 📦",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}