import 'package:flutter/material.dart';
import 'package:epichub/loginUI.dart';
import 'package:epichub/signIn.dart';
import 'dart:async';

class getStartedUI extends StatefulWidget {
  const getStartedUI({super.key});

  @override
  State<getStartedUI> createState() => _getStartedUIState();
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 41, 8, 99),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}

class _getStartedUIState extends State<getStartedUI> {
  String dispayedText = '';
  final String fullText = 'Get Started with Renthub';
  int index = 0;
  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Timer.periodic(Duration(milliseconds: 90), (timer) {
      if (index < fullText.length) {
        setState(() {
          dispayedText += fullText[index];
          index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 8, 99),
      body: Center(
        // Centers the entire column
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dispayedText,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign:
                    TextAlign.center, // Centers text within its container
              ),
              const SizedBox(height: 17),
              Row(
                // Row for side-by-side buttons
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centers the buttons horizontally
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Loading(),
                      );
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                      // Add log-in functionality here
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor: Colors.white),
                    child: const Text('Log In'),
                  ),
                  const SizedBox(width: 10), // Space between buttons
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Loading(),
                      );
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor: Colors.white),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
