import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:epichub/mpesaApi.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mpesa Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MpesaPaymentScreen(),
    );
  }
}

void main() {
  MpesaFlutterPlugin.setConsumerKey(
      'y0DuJDYsBHz4gQ7Anb9GEsaoc3kfwEvtHt4CFUy7nCt87kr2');
  MpesaFlutterPlugin.setConsumerSecret(
      '9b7buDJWVDKYeuhtBvqSNaQwa5ZzvWr3nefeifTOzicn1yKPI3HO8Gf9qsbMTGdm');
  runApp(MyApp());
}
