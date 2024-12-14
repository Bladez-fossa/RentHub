import 'package:flutter/material.dart';
import 'package:epichub/mpesaApi.dart';

class Tenants extends StatelessWidget {
  const Tenants({super.key}); // Add const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenants'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await initializeMpesaCredentials(); // Initialize M-Pesa credentials
                await MpesaPaymentScreen()
                    .startTransaction(); // Call startTransaction
              },
              child: const Text('Start M-Pesa Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
