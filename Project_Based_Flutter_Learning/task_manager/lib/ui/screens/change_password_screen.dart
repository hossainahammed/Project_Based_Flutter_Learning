import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/screen_bagground.dart';
import '../utils/asset_paths.dart';
import 'Sign-Up-Screen.dart';

class changePasswordScreen extends StatefulWidget {
  const changePasswordScreen({super.key});
  static const String name = '/change-password';

  @override
  State<changePasswordScreen> createState() =>
      _changePasswordScreenState();
}

class _changePasswordScreenState extends State<changePasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmpasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.grey),
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
                    validator: (String?value){
                      if(value?.isEmpty ?? true){
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
                    onPressed: _onTapSignInButton,
                    child: Text('Confirm'),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account ?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer:
                            TapGestureRecognizer()
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
    // if (_formkey.currentState!.validate()) {
    //   //TODO:Sign in with Api
    // }
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
  }

  void dispose() {
    _passwordTEController.dispose();
    _confirmpasswordTEController.dispose();
    super.dispose();
  }
}
