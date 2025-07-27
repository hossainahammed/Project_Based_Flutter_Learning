import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../controllers/auth_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/screen_bagground.dart';
import '../widgets/snackbar_message.dart';
import 'Sign-Up-Screen.dart';
import 'forgot_passaword_email_screen.dart';
import 'main_nav_bar_holder_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _signInProgress = false;
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
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a valid Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _signInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text(
                            'Forget password ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have any account ?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = _onTapSignUpButton,
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
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formkey.currentState!.validate()) {
      _signIn();
    }
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainNavBarHolderScreen.name,
      (predicate) => false,
    );
  }

  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});
    Map<String, String> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
      isFromLogin: true,
    );
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);

      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   MainNavBarHolderScreen.name,
      //   (predicate) => false,
      // );
      //--------------------------------- OR -------------------------
      // Get.to(() => const MainNavBarHolderScreen());
      //--------------------------------- OR -------------------------
      // Get.toNamed(MainNavBarHolderScreen.name);
      // If we want to it remove all previous screen then sign in .then we need to use   Get.offAllNamed(MainNavBarHolderScreen.name);
      Get.offAllNamed(MainNavBarHolderScreen.name);
      
    } else {
      _signInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.pushNamed(context, ForgotPaswordEmailScreen.name);
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
