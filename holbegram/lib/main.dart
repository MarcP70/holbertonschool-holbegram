import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:holbegram/screens/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for the input fields
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return MaterialApp(
      title: 'Holbegram',
      /*
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 62, 13, 146)),
        useMaterial3: true,
      ),
      */
      // The home is now LoginScreen, with controllers passed as arguments
      home: LoginScreen(
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}
