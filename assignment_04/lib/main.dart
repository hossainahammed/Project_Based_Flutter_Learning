import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';
void main(){
  //runApp(TaskManagerApp());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      DevicePreview(
        enabled: true,

        builder: (context)=>TaskManagerApp() ,
        //builder: (context)=>waterTracker() ,
      )
  );
}