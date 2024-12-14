import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:epichub/currencyDemo.dart'; // Assuming this fetches currencies.
import 'package:epichub/maintenance.dart'; // Assuming this fetches maintenance info.
import 'package:epichub/HelpPage.dart'; // Assuming this fetches the help page.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epichub/getStartedScreen.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class Drawerr extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkTheme;

  const Drawerr({
    super.key,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  String? _selectedCurrency;
  Map<String, String> _currencies = {};

  @override
  void initState() {
    super.initState();
    _loadCurrencies(); // Load currencies when the drawer is opened
  }

  Future<void> _loadCurrencies() async {
    try {
      Map<String, String> currencies =
          await fetchCurrencies(); // Fetch currencies using API
      setState(() {
        _currencies = currencies;
      });
    } catch (e) {
      print("Error loading currencies: $e");
    }
  }

  Future<void> signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => getStartedUI()));
  }

  @override
  Widget build(BuildContext context) {
    bool isLightMode =
        !widget.isDarkTheme; // Toggle between light and dark mode

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.account_circle_outlined,
              size: 36,
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.brightness_2_sharp),
            title: const Text("T H E M E"),
            children: [
              SwitchListTile(
                title: const Text("Light Mode"),
                value: isLightMode,
                onChanged: (bool value) {
                  widget.toggleTheme(!value); // Toggle theme
                  Navigator.pop(context); // Close the drawer
                },
              ),
              SwitchListTile(
                title: const Text("Dark Mode"),
                value: widget.isDarkTheme,
                onChanged: (bool value) {
                  widget.toggleTheme(value); // Toggle theme
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
          //to add a showmodalview function so that the currencies wont be shohow in the app drawer
          ExpansionTile(
            leading: const Icon(FontAwesomeIcons.dollarSign),
            title: const Text("C U R R E N C Y"),
            children: [
              _currencies.isEmpty
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading spinner if currencies haven't loaded
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
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
            ],
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('H E L P / S U P P O R T'),
            onTap: () {
              Navigator.pop(context); // Close current screen if necessary
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HelpPage()), // Navigate to help page
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('R E P O R T S'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to reports
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('M A I N T E N A N C E'),
            onTap: () {
              Navigator.pop(context); // Close current screen if necessary
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        maintenance()), // Navigate to maintenance page
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('L O G O U T'),
            onTap: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Log out"), // Dialog title
                    content: const Text(
                        "Are you sure you want to log out?"), // Dialog message
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("No"), // "No" button
                      ),
                      TextButton(
                        onPressed: () {
                          signOut();
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Yes"), // "Yes" button
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
