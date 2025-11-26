import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class FakeMap extends StatefulWidget {
  const FakeMap({super.key});
  @override
  State<FakeMap> createState() => _FakemapState();
}

class _FakemapState extends State<FakeMap> {
  final MapController _mapController = MapController();
  LatLng _center = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text(
          "Fake Map",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[900],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(mapController: _mapController,
          options: MapOptions(
            initialCenter: _center,
            initialZoom: 2,
            onTap: (tapPosition, LatLng)  {
              setState(() {
                _center = LatLng;
              });
            }
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a','b','c'],
              userAgentPackageName: 'com.smkin.fake_map',
            ),
            MarkerLayer(markers: [
              Marker(point: _center, width: 90, height: 90, child: const Icon(
                Icons.location_pin,
                color:  Colors.deepPurple,
                size: 35,
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
              child: const Icon(Icons.public, color: Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }
}