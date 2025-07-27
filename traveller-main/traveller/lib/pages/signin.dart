import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_container.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username = "", password = "";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> userLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username') ?? '';
    final storedPassword = prefs.getString('password') ?? '';

    if (username == storedUsername && password == storedPassword) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainContainer()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Invalid username or password",
          style: TextStyle(fontSize: 16.0),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                username = value;
              },
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                userLogin();
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}