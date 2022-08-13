import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';
import "package:latlong2/latlong.dart" as latLng;

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FindSpotController findSpotController = Get.put(FindSpotController());
    // Completer<GoogleMapController> _controller = Completer();
    return Scaffold(
      appBar: AppBar(),
      body:FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.5, -0.09),
          zoom: 1.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(
            markers: findSpotController.markers
          ),
        ],
      ),
    );
  }
}


