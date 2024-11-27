import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Ajout du package Provider
import './screens/login_screen.dart';
import './screens/home.dart';
import './providers/user_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Déclaration des contrôleurs en tant que variables de classe
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {
    // Disposez correctement de tous les contrôleurs
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Configuration du provider pour la gestion de l'utilisateur
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Holbegram',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Définir la page de connexion par défaut
        home: LoginScreen(
          emailController: emailController,
          passwordController: passwordController,
          usernameController: usernameController,
          passwordConfirmController: passwordConfirmController,
        ),
      ),
    );
  }
}
