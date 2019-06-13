import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  GoogleMapController mapController;

  void initState() {
    super.initState();
    initMarker();
  }

  initMarker() {
    var markerIdVal = Random().nextInt(10000);
    final MarkerId markerId = MarkerId(markerIdVal.toString());

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(50.014791, 36.2263021),
      infoWindow: InfoWindow(title: markerIdVal.toString(), snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 375.0,
              width: double.infinity,
              child: GoogleMap(
                onMapCreated: onMapCreated,
                markers: Set<Marker>.of(markers.values),
                initialCameraPosition: const CameraPosition(
                    target: LatLng(50.014791, 36.2263021), zoom: 15.0),
              ),
            ),
          ],
        )
      ],
    ));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
