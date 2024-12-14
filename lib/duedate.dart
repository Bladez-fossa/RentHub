import 'package:flutter/material.dart';

class DueDatesPage extends StatelessWidget {
  const DueDatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Due Dates'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage('avatar.png'), // Replace with your avatar image
              ),
              SizedBox(width: 16.0),
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0), // Add some vertical padding
                child: Text(
                  'Tenant 1 due date: 1st of each month',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Tenant 2 due date: 28th of each month',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Tenant 3 due date: 5th of each month',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
