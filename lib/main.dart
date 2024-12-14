import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epichub/loginUI.dart';
import 'package:epichub/apartmentdetails.dart';
import 'package:epichub/stats.dart';
import 'package:epichub/tenants.dart';
import 'package:epichub/calender.dart';
import 'package:epichub/drawer.dart';
import 'package:epichub/getStartedScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartment Details',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: AuthWrapper(toggleTheme: _toggleTheme),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final Function(bool) toggleTheme;

  const AuthWrapper({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return MainPage(
            toggleTheme: toggleTheme,
            isDarkTheme: Theme.of(context).brightness == Brightness.dark,
          );
        } else {
          return getStartedUI();
        }
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkTheme;

  const MainPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Tenants(),
    AddApartmentsPage(),
    Stats(),
    Calendar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ['Tenants', 'Apartment', 'Statistics', 'Calendar'][_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 153, 94),
      ),
      drawer: Drawerr(
        toggleTheme: widget.toggleTheme,
        isDarkTheme: widget.isDarkTheme,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Tenants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment, size: 28),
            label: 'Apartment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart, size: 28),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 28),
            label: 'Calendar',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 103, 103, 103),
        backgroundColor: const Color.fromARGB(255, 189, 191, 191),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
