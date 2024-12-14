import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:epichub/shared.dart'; // Import shared.dart for state checker
import 'main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
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

class _SignInPageState extends State<SignInPage> {
  bool? isLogin;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String emailError = '';
  String passwordError = '';

  void _validateAndProceed() {
    setState(() {
      // Reset error messages
      emailError = '';
      passwordError = '';

      // Validate fields
      if (emailController.text.isEmpty) {
        emailError = 'Email is required';
      }
      if (passwordController.text.isEmpty) {
        passwordError = 'Password is required';
      }

      //if (emailError.isEmpty && passwordError.isEmpty) {}
    });
  }

  Future<void> registerUser(String email, String password) async {
    if (emailError.isEmpty && passwordError.isEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("User registered successfully");
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserLoginState(); // Call the method to check login state
  }

  // Method to check login state using shared.dart
  Future<void> checkUserLoginState() async {
    final loginState = await Shared.getUserSharedPreferences();
    setState(() {
      isLogin = loginState;
    });
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            '481929803319-l2nbc30uisogt6b9l6je4iktlc95mb56.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignInPage()));
        return;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainPage(
                  toggleTheme: (isDark) {
                    // Provide your theme toggle logic here
                  },
                  isDarkTheme: Theme.of(context).brightness == Brightness.dark,
                )));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Show a snackbar or dialog with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is not authenticated or saved login state is false
        if (!snapshot.hasData && !(isLogin ?? false)) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 41, 8, 99),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Text('Email', style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter your email address',
                      prefixIcon: const Icon(Icons.email_rounded),
                      errorText: emailError.isEmpty ? null : emailError,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Password', style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Create a password for your account',
                      prefixIcon: const Icon(Icons.lock),
                      errorText: passwordError.isEmpty ? null : passwordError,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Confirm Password',
                      style: TextStyle(fontSize: 20)),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm your password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      registerUser(email, password);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginScreen()),
                      // );
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Loading(),
                      );
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);

                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Continue with ',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Image.asset('assets/google_logo.png',
                            height: 24, width: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // If the user is authenticated or already logged in, show the MainPage
        return MainPage(
          toggleTheme: (isDark) {
            // Provide your theme toggle logic here
          },
          isDarkTheme: Theme.of(context).brightness == Brightness.dark,
        );
      },
    );
  }
}
