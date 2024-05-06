import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  // Tọa độ lúc mới tạo
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.000, -122.000),
    zoom: 9,
  );
  
  // Tạo list marker
  final Set<Marker> _markers = {};


  // Tạo list style
  MapType mapTye = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget> [
        DropdownButton<MapType>(
              style: const TextStyle(color: Colors.black,fontSize: 20,),
              value: mapTye,
              items: const [
                  DropdownMenuItem(
                    value: MapType.normal,
                    child: Text("Normal"),
                  ),
                  DropdownMenuItem(
                    value: MapType.hybrid,
                    child: Text("Hybrid"),
                  ),
                  DropdownMenuItem(
                      value: MapType.satellite,
                      child: Text("Satellite")
                  ),
                  DropdownMenuItem(
                      value:  MapType.terrain,
                      child: Text("Terrain")
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    mapTye = value!;
                  });
                }),
        ]
      ), 
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: mapTye,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}