import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/urls.dart';
import '../widgets/screen_bagground.dart';
import 'sign_in_screen.dart';

class changePasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const changePasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });
  static const String name = '/change-password';

  @override
  State<changePasswordScreen> createState() => _changePasswordScreenState();
}

class _changePasswordScreenState extends State<changePasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmpasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late String _email;
  late String _otp;


  @override

  // void initState() {
  //   super.initState();
  //   final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //   _email = args['email'] ?? '';
  //   _otp = args['otp'] ?? '';
  // }

  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final args = ModalRoute.of(context)?.settings.arguments as String?;
  //   if (args != null && args.isNotEmpty) {
  //     _email = args;
  //     print('Email passed to PinVerificationScreen: $_email');
  //   } else {
  //     _showError('No email found for OTP verification');
  //     Navigator.pop(context);
  //   }
  // }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _email = args['email'] ?? '';
      _otp = args['otp'] ?? '';
    }
    else {
      // Handle the case where arguments are not provided
      _showError('Email and OTP are required.');
      Navigator.pop(context); // Optionally navigate back
    }
    print('Email: $_email, OTP: $_otp');
  }


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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Password should be more than 6 letters.',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a valid Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    controller: _confirmpasswordTEController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if ((value ?? '') != _passwordTEController.text) {
                        return "Confirm Password doesn't match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Text('Confirm'),
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
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
      String newPassword = _passwordTEController.text.trim();
      // Call the API to change the password
      _changePassword(newPassword);
      final url = Urls.resetPasswordUrl;
    }
  }
  Future<void> _changePassword(String newPassword) async {
    final url = Urls.resetPasswordUrl;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, dynamic> body = {
      'email': _email,
      'otp': _otp, // changed from 'OTP' to 'otp'
      'password': newPassword,
    };

    print('🔐 Sending password reset request...');
    print('➡️ URL: $url');
    print('📦 BODY: $body');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      print("📬 Response status: ${response.statusCode}");
      print("📨 Response body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('✅ Password reset successful.')),
          );
          Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (_) => false);
        }
      } else {
        final errorMsg = jsonResponse['data'] ?? '❌ Password reset failed.';
        _showError(errorMsg);
      }

    } catch (e) {
      _showError('🚨 Error: ${e.toString()}');
    }
  }

  // Future<void> _changePassword(String newPassword) async {
  //   final url = Urls.resetPasswordUrl;
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //
  //   final Map<String, dynamic> body = {
  //     'email': _email,
  //     'OTP': _otp,
  //     'password': newPassword,
  //   };
  //
  //   print('Sending password reset request...');
  //   print('URL: $url');
  //   print('BODY: $body');
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );
  //
  //     print("Response status: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = jsonDecode(response.body);
  //       if (jsonResponse['status'] == 'success') {
  //         if (mounted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Password reset successful.')),
  //           );
  //         }
  //         Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (_) => false);
  //       } else {
  //         _showError(jsonResponse['data'] ?? 'Password reset failed.');
  //       }
  //
  //     } else {
  //       _showError('Password reset failed. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     _showError('An error occurred: ${e.toString()}');
  //   }
  // }




  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate) => false);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmpasswordTEController.dispose();
    super.dispose();
  }
}



