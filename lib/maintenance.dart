import 'package:flutter/material.dart';

class maintenance extends StatelessWidget {
  const maintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance'),
      ),
      body: const Center(
        child: Text('This is the Maintenance Page'),
      ),
    );
  }
}
