import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:device_preview/device_preview.dart';

void main(){
  runApp(
      const MyApp());
  //     DevicePreview(
  //   enabled: true,
  //   builder: (context)=>const MyApp(),
  // ));

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:HomeScreen(),

    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
     body: GoogleMap(
       initialCameraPosition: CameraPosition(
         target: LatLng(23.79348696073093, 90.40612976653253),
         zoom:16
       ),
       onMapCreated: (GoogleMapController controller){
         _mapController =controller;
       },
       myLocationEnabled: true,
       myLocationButtonEnabled: true,
       mapType: MapType.normal,
       onCameraMove: (CameraPosition cameraPosition){
         print(cameraPosition);
       },
       onCameraIdle:(){
         print('Fetching Data');
       } ,
       zoomControlsEnabled: true,
       zoomGesturesEnabled: true,
       mapToolbarEnabled: true,
       markers: <Marker>{
         Marker(
           markerId: MarkerId('my-office'),
           position: LatLng(23.79387450015791, 90.40334499572938),
           draggable: true,
           flat: false,
           onTap: (){
             print('Tap on my office marker');
           },
           onDrag: (LatLng latLng){
             print(latLng);
           },
           onDragEnd: (LatLng latLng){
             print(latLng);
           },
           onDragStart: (LatLng latLng) {
             print(latLng);
           },
         )
       },
     ),
    );
  }
}

