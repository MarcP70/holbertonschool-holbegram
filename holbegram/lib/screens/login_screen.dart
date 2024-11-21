import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'signup_screen.dart';
import 'auth/upload_image_screen.dart';
import '../methods/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  const LoginScreen({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  final AuthMethods _authMethods = AuthMethods();

  Future<void> _login() async {
    // Appel de la fonction login et stockage du résultat
    String res = await _authMethods.login(
      email: widget.emailController.text,
      password: widget.passwordController.text,
    );

    // Vérification du résultat pour afficher un Snackbar
    if (res == "success") {
      // Affiche un Snackbar avec le texte "Login" en cas de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPicture(
            email: widget.emailController.text,
            username: 'John Doe',
            password: widget.passwordController.text,
          ),
        ),
      );
    } else {
      // Affiche un Snackbar avec le message d'erreur en cas d'échec
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 20),
            const Image(
              width: 80,
              height: 60,
              image: AssetImage('assets/images/logo.webp'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  TextFieldInput(
                    controller: widget.emailController,
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordController,
                    isPassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(218, 226, 37, 24),
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(
                                  emailController: widget.emailController,
                                  usernameController: widget.usernameController,
                                  passwordController: widget.passwordController,
                                  passwordConfirmController:
                                      widget.passwordConfirmController,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(218, 226, 37, 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
