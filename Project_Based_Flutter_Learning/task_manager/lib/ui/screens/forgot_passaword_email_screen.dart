import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/urls.dart';
import '../widgets/screen_bagground.dart';
import 'pin_verification_screen.dart';

class ForgotPaswordEmailScreen extends StatefulWidget {
  const ForgotPaswordEmailScreen({super.key});
  static const String name = '/forgot-password-email';

  @override
  State<ForgotPaswordEmailScreen> createState() => _ForgotPaswordEmailScreenState();
}

class _ForgotPaswordEmailScreenState extends State<ForgotPaswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBagground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Center(
                    child: Text(
                      'Your Email Address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'A six-digit OTP will be sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign In',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      String email = _emailTEController.text.trim();
      _sendOtp(email);
    }
  }

  Future<void> _sendOtp(String email) async {
    final url = Urls.verifyEmailUrl(email);
    print("Sending OTP to URL: $url");
    try {
      final response = await http.get(Uri.parse(url));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("Response from server: $jsonResponse");
        if (jsonResponse['status'] == 'success') {
          print("OTP sent to email.");
          // Navigate to the Pin Verification Screen and pass the email
          Navigator.pushNamed(context, PinVerificationScreen.name, arguments: email);
        } else {
          _showError(jsonResponse['message'] ?? 'Failed to send OTP.');
        }
      } else {
        _showError('Failed to send OTP. Server error ${response.statusCode}');
      }
    } catch (e) {
      _showError('Failed to send OTP. ${e.toString()}');
    }
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}