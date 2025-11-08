import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FakeJoMap extends StatefulWidget {
  const FakeJoMap({super.key});

  @override
  State<FakeJoMap> createState() => _FakeJoMapState();
}

class _FakeJoMapState extends State<FakeJoMap> {
  final MapController _mapController = MapController();
  LatLng _center = LatLng(0, 0); // titik awal: tengah dunia

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text(
          "FakeJo's World Map",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 2.5,
              onTap: (tapPosition, latLng) {
                setState(() {
                  _center = latLng;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.fakejo_map',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _center,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 15,
            right: 15,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                _mapController.move(LatLng(0, 0), 2.5);
              },
              child: const Icon(Icons.public, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
