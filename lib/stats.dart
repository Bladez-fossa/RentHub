import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  final String totMonthlyRent = '/40000';
  final String totTenant = '/40000';
  final String totApartments = '/40000';
  final String totPH = '/40000';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OVERALL STATISTICS"),
        backgroundColor: const Color.fromARGB(255, 79, 230, 157),
      ),
      body: ListView(
        children: [
          const Text(
            'MONETARY STATISTICS',
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          const Text(
            'Total montly rent  ',
            style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                //smallest width that can fit all the contents (sind sie)
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.grey), // Border around the box
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  child: Text(
                    totMonthlyRent,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )),
          const Text(
            'Total Number of empty apartments ',
            style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                //smallest width that can fit all the contents (sind sie)
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.grey), // Border around the box
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  child: Text(
                    totApartments,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )),
          const Text(
            'PLACEHOLDER',
            style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                //smallest width that can fit all the contents (sind sie)
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.grey), // Border around the box
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  child: Text(
                    totTenant,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )),
          const Text(
            'PLACEHOLDER ',
            style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                //smallest width that can fit all the contents (sind sie)
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.grey), // Border around the box
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  child: Text(
                    totPH,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

//to be continued
void main() {
  runApp(const MaterialApp(
    home: Stats(),
  ));
}
