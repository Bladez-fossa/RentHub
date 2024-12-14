import 'package:flutter/material.dart';
import 'package:epichub/currencyDemo.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({super.key});

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  Map<String, String> _currencies = {}; // stores a map of currency codes (like USD, EUR) as the keys and currency names (like "United States Dollar") as the values.
  String? _selectedCurrency;//store the currently selected currency code from the dropdown. its nullabble thus can hold only a string or it can be null

  @override
  void initState() { //called when the state object is created. It's used to initialize anything before the widget is displayed.
    super.initState();
    _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {  //async- does nor return any data
    try {
      Map<String, String> currencies = await fetchCurrencies();//Calls the fetchCurrencies() function, waits for it to complete, and assigns the result (list of currencies) to currencies.
      setState(() {
        _currencies = currencies; //Updates the _currencies variable with the loaded currencies
      });
    } catch (e) {
      print("Error loading currencies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Dropdown')),
      body: _currencies.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner if currencies haven't loaded yet
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedCurrency,
                hint: const Text("Select a currency"),
                items: _currencies.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text('${entry.value} (${entry.key})'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue;
                  });
                },
              ),
            ),
    );
  }
}
