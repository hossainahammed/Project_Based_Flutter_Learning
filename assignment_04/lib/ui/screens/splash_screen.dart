import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/auth_controller.dart';
import '../utils/asset_paths.dart';
import '../widgets/screen_bagground.dart';
import 'main_nav_bar_holder_screen.dart';
import 'sign_in_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name='/';
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    bool isLogedIn = await AuthController.isUserLoggedIn();
    if(isLogedIn){
      Navigator.pushReplacementNamed(context, MainNavBarHolderScreen.name);
    }
    else{
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => SignInScreen()),
    // );
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBagground(
        child: Center(
          child: SvgPicture.asset(AssetPaths.logoSvg),
        ),
      ),
    );
  }
}
