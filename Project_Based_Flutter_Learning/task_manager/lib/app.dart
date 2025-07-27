import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager/ui/screens/Sign-Up-Screen.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/complete_task_list_screen.dart';
import 'package:task_manager/ui/screens/forgot_passaword_email_screen.dart';
import 'package:task_manager/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState>navigator=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigator,
      theme:ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      ),
        inputDecorationTheme: InputDecorationTheme(

            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16,vertical: 12
            ),
            hintStyle: TextStyle(
                color: Colors.grey
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),

        ),
        elevatedButtonTheme:ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white

          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green

          )
        )
      ),
      // home: SplashScreen(),
      initialRoute: '/',
      routes:{
        // '/':(context)=> SplashScreen(),
        SplashScreen.name:(context)=> SplashScreen(),
        SignInScreen.name:(context)=>SignInScreen(),
        SignUpScreen.name:(context)=>SignUpScreen(),
        ForgotPaswordEmailScreen.name:(context)=>ForgotPaswordEmailScreen(),
        PinVerificationScreen.name:(context)=>PinVerificationScreen(),
        changePasswordScreen.name:(context)=>changePasswordScreen(),
        MainNavBarHolderScreen.name:(context)=>MainNavBarHolderScreen(),
        AddNewTaskScreen.name:(context)=>AddNewTaskScreen(),
        UpdateProfileScreen.name:(context)=>UpdateProfileScreen(),


    },
    );
  }
}
