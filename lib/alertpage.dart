import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  int? _selectedDeliveryOption;
  final TextEditingController _messageController = TextEditingController(
      text:
          'Your rent is due in 3 days. Please avoid being caught by deadline');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _sendSMS(String message, String phoneNumber) async {
    final String smsUrl = 'sms:$phoneNumber?body=$message';
    if (await canLaunchUrl(Uri.parse(smsUrl))) {
      await launchUrl(Uri.parse(smsUrl));
    } else {
      _showResultDialog('Could not launch SMS app');
    }
  }

  void _sendWhatsApp(String message, String phoneNumber) async {
    final whatsappUrl =
        "https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      _showResultDialog('Could not launch WhatsApp');
    }
  }

  void _sendEmail(String message, String recipient) async {
    const String subject = 'Rent Reminder';
    final String emailUrl = 'mailto:$recipient?subject=$subject&body=$message';
    if (await canLaunchUrl(Uri.parse(emailUrl))) {
      await launchUrl(Uri.parse(emailUrl),
          mode: LaunchMode.externalApplication);
    } else {
      _showResultDialog('Could not launch email app');
    }
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Message'),
        backgroundColor: const Color.fromARGB(255, 11, 153, 94),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _messageController,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Alert Message',
              ),
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Via',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<int>(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mail_outline),
                  SizedBox(width: 8.0),
                  Text('Email'),
                ],
              ),
              value: 0,
              groupValue: _selectedDeliveryOption,
              onChanged: (value) =>
                  setState(() => _selectedDeliveryOption = value),
            ),
            if (_selectedDeliveryOption == 0)
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient Email',
                ),
                style: const TextStyle(fontSize: 16.0),
              ),
            RadioListTile<int>(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sms_outlined),
                  SizedBox(width: 8.0),
                  Text('SMS'),
                ],
              ),
              value: 1,
              groupValue: _selectedDeliveryOption,
              onChanged: (value) =>
                  setState(() => _selectedDeliveryOption = value),
            ),
            RadioListTile<int>(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.insert_comment),
                  SizedBox(width: 8.0),
                  Text('WhatsApp'),
                ],
              ),
              value: 2,
              groupValue: _selectedDeliveryOption,
              onChanged: (value) =>
                  setState(() => _selectedDeliveryOption = value),
            ),
            if (_selectedDeliveryOption == 1 || _selectedDeliveryOption == 2)
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient Phone Number',
                  hintText: 'For WhatsApp, include country code',
                ),
                style: const TextStyle(fontSize: 16.0),
                keyboardType: TextInputType.phone,
              ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  final alertMessage = _messageController.text;
                  if (_selectedDeliveryOption == 0) {
                    final recipientEmail = _emailController.text;
                    _sendEmail(alertMessage, recipientEmail);
                  } else if (_selectedDeliveryOption == 1) {
                    final phoneNumber = _phoneController.text;
                    _sendSMS(alertMessage, phoneNumber);
                  } else if (_selectedDeliveryOption == 2) {
                    final phoneNumber = _phoneController.text;
                    _sendWhatsApp(alertMessage, phoneNumber);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                ),
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
