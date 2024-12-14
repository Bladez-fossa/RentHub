import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:epichub/main.dart'; // Ensure MainPage is accessible
import 'package:epichub/signIn.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // User is not authenticated, show the login screen
          return LoginScreen();
        }

        // User is authenticated, navigate to MainPage
        return MainPage(
          toggleTheme: (isDark) {}, // Provide your theme toggle logic
          isDarkTheme: Theme.of(context).brightness == Brightness.dark,
        );
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 41, 8, 99),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Reset error message on new attempt
    });

    try {
      // Firebase authentication login logic
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If login is successful, navigate to MainPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            toggleTheme: (isDark) {}, // Provide your theme toggle logic
            isDarkTheme: Theme.of(context).brightness == Brightness.dark,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors like invalid credentials
      setState(() {
        errorMessage = e.message ?? 'Login failed. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 8, 99),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SignInPage()), //REPLACE WITH PASSWAORD CHANGE PAGE
                );
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  isLoading ? null : _login, // Disable button while loading
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Loading(),
                );
                await Future.delayed(Duration(seconds: 3));
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text("Don't have an account? Sign up"),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
