import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final TextEditingController _searchController = TextEditingController();
  late MapController _mapController;
  LatLng? _currentLocation;
  String? _searchedPlaceName;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<void> _searchLocation(String name) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$name&format=json&limit=1');

    try {
      final response = await http.get(url, headers: {
        'User-Agent': 'FlutterApp' 
      });

      final data = json.decode(response.body);

      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        final location = LatLng(lat, lon);

        setState(() {
          _currentLocation = location;
          _searchedPlaceName = name;
          _markers = [
            Marker(
              point: location,
              width: 40,
              height: 40,
              child: Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          ];
        });

        _mapController.move(location, 16);
      } else {
        setState(() {
          _searchedPlaceName = null;
          _markers = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('place "$name" not exist')),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error while searching')),
      );
    }
  }

  void _openInGoogleMaps() async {
    if (_currentLocation == null) return;
    final url =
        'https://www.google.com/maps/search/?api=1&query=${_currentLocation!.latitude},${_currentLocation!.longitude}';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Can't open Google Maps")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(31.95, 35.9), 
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search for a place...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) =>
                      _searchLocation(value.trim().toLowerCase()),
                ),
              ),
            ),
            if (_currentLocation != null && _searchedPlaceName != null)
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.place, color: Colors.red, size: 30),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_searchedPlaceName!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("Place", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.directions, color: Colors.blue),
                          onPressed: _openInGoogleMaps,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
