import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username = "", password = "";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    if (username.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('password', password);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 16.0),
        ),
      ));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Please fill in all fields",
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
              "Sign Up",
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
                registerUser();
              },
              child: const Text("Register"),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: const Text(
                "Already have an account? Sign In",
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