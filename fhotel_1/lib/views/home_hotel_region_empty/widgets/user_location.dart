import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationToAddressExample extends StatefulWidget {
  @override
  _LocationToAddressExampleState createState() => _LocationToAddressExampleState();
}

class _LocationToAddressExampleState extends State<LocationToAddressExample> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      print('${place.subAdministrativeArea},${place.administrativeArea}');

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location to Address')),
      body: Center(
        child: _currentPosition == null
            ? ElevatedButton(
          onPressed: _getCurrentLocation,
          child: Text('Get Current Location'),
        )
            : Text(
          _currentAddress ?? 'Getting address...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
