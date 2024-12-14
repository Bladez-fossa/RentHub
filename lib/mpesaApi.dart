import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mpesa Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MpesaPaymentScreen(),
    );
  }
}

Future<void> initializeMpesaCredentials() async {
  try {
    print("Initializing M-Pesa credentials...");
    await MpesaFlutterPlugin.setConsumerKey(
        'y0DuJDYsBHz4gQ7Anb9GEsaoc3kfwEvtHt4CFUy7nCt87kr2');
    print("Consumer Key set successfully.");

    await MpesaFlutterPlugin.setConsumerSecret(
        '9b7buDJWVDKYeuhtBvqSNaQwa5ZzvWr3nefeifTOzicn1yKPI3HO8Gf9qsbMTGdm');
    print("Consumer Secret set successfully.");
  } catch (e) {
    print("Error initializing M-Pesa credentials: $e");
  }
}

class MpesaPaymentScreen extends StatelessWidget {
  const MpesaPaymentScreen({super.key});

  Future<void> startTransaction() async {
    await initializeMpesaCredentials(); // Ensure credentials are set

    try {
      print("Starting M-Pesa STK Push transaction...");

      // Initialize the Mpesa STK Push
      dynamic transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: 1,
        partyA: "254729008219",
        partyB: "174379",
        callBackURL: Uri.parse(
            "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"),
        accountReference: "Flutter App",
        phoneNumber: "254729008219",
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke/"),
        transactionDesc: "Payment Description",
        passKey:
            "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      );

      print("Transaction initialization successful:");
      print("Transaction Details: $transactionInitialisation");
    } catch (e) {
      print("Caught exception during transaction: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M-Pesa Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Make Payment'),
          onPressed: () {
            print("Make Payment button pressed.");
            startTransaction();
          },
        ),
      ),
    );
  }
}
