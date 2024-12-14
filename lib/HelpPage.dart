import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help/Support'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add navigation logic for starting the tutorial
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => TutorialPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 124, 233, 184), // Change button color here
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0), // Adjust vertical padding as needed
                  child: SizedBox(
                    width: double
                        .infinity, // Makes the button take full width inside its parent
                    child: Text(
                      'Start Tutorial',
                      textAlign:
                          TextAlign.center, // Centers text inside the button
                      style: TextStyle(
                        color: Colors.black, // Change text color here
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            buildSectionTitle('Frequently Asked Questions'),
            buildFAQs(),
            buildDivider(),
            buildSectionTitle('Contact Us'),
            buildContactInfo(),
            buildDivider(),
            buildSectionTitle('Tutorials and Guides'),
            buildTutorials(),
            buildDivider(),
            buildSectionTitle('Troubleshooting'),
            buildTroubleshooting(),
            buildDivider(),
            buildSectionTitle('Updates and News'),
            buildUpdates(),
            buildDivider(),
            buildSectionTitle('Privacy Policy and Terms of Service'),
            buildPrivacyTerms(),
            buildDivider(),
            buildSectionTitle('Feedback'),
            buildFeedback(),
            buildDivider(),
            buildSectionTitle('Accessibility'),
            buildAccessibility(),
            buildDivider(),
            buildSectionTitle('App Version'),
            buildAppVersion(),
            buildDivider(),
            buildSectionTitle('Community and Social'),
            buildCommunity(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildFAQs() {
    // Replace with actual FAQs widget or text
    return Text('Include FAQs here');
  }

  Widget buildContactInfo() {
    // Replace with actual contact information widget or text
    return Text('Include contact information here');
  }

  Widget buildTutorials() {
    // Replace with actual tutorials and guides widget or text
    return Text('Include tutorials and guides here');
  }

  Widget buildTroubleshooting() {
    // Replace with actual troubleshooting tips widget or text
    return Text('Include troubleshooting tips here');
  }

  Widget buildUpdates() {
    // Replace with actual updates and news widget or text
    return Text('Include updates and news here');
  }

  Widget buildPrivacyTerms() {
    // Replace with actual privacy policy and terms widget or text
    return Text('Include privacy policy and terms here');
  }

  Widget buildFeedback() {
    // Replace with actual feedback mechanism widget or text
    return Text('Include feedback mechanism here');
  }

  Widget buildAccessibility() {
    // Replace with actual accessibility information widget or text
    return Text('Include accessibility information here');
  }

  Widget buildAppVersion() {
    // Replace with actual app version information widget or text
    return Text('Include app version information here');
  }

  Widget buildCommunity() {
    // Replace with actual community and social links widget or text
    return Text('Include community and social links here');
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }
}
