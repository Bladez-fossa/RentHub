import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 300, // Mimic a mobile screen width
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfilePicture(),
              SizedBox(height: 20),
              StatisticText(label: 'Monthly total:', value: '40000'),
              StatisticText(label: 'Tenants\' debts:', value: '32200'),
              StatisticText(label: 'Yearly total:', value: '3900000'),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 40,
      backgroundImage: NetworkImage(
          'https://example.com/profile_picture.png'), // Replace with actual image URL or asset
    );
  }
}

class StatisticText extends StatelessWidget {
  final String label;
  final String value;

  const StatisticText({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        '$label $value',
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}
