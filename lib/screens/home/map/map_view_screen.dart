import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/top.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;

class MapViewScreen extends StatefulWidget {
  final LatLng destination;
  final String title;

  const MapViewScreen({super.key, required this.destination, required this.title});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  LatLng? userLocation;
  List<LatLng> routePoints = [];

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted == loc.PermissionStatus.granted) {
      final locData = await location.getLocation();
      final currentLoc = LatLng(locData.latitude!, locData.longitude!);
      setState(() {
        userLocation = currentLoc;
      });
      await fetchRoute(currentLoc, widget.destination);
    }
  }

  Future<void> fetchRoute(LatLng from, LatLng to) async {
    const apiKey = '5b3ce3597851110001cf6248ad832b746aa64e21abdec26324f0e5f1';
    final url = 'https://api.openrouteservice.org/v2/directions/driving-car';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': apiKey,
      },
      body: jsonEncode({
        'coordinates': [
          [from.longitude, from.latitude],
          [to.longitude, to.latitude],
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final features = data['features'] as List?;
      if (features == null || features.isEmpty) return;

      final geometry = features[0]['geometry']['coordinates'] as List;

      setState(() {
        routePoints = geometry.map((point) => LatLng(point[1], point[0])).toList();
      });
    } else {
      print('Route fetch failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Top(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: responsiveHeight(context, 50),
                    right: responsiveWidth(context, 20),
                    left: responsiveWidth(context, 20),
                  ),
                  child: CustomAppText(
                    text: widget.title,
                    fontSize: 16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: responsiveHeight(context, 20)),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: FlutterMap(
              options: MapOptions(
                initialCenter: widget.destination,
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: widget.destination,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                    if (userLocation != null)
                      Marker(
                        point: userLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
