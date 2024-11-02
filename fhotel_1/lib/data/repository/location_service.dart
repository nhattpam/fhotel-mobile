import 'dart:math';

import 'package:fhotel_1/data/models/hotel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late Position _currentPosition; // Make it late to ensure it gets initialized

  // Constructor to initialize with current position
  LocationService(this._currentPosition);
  Future<List<Map<String, dynamic>>> LocationsByDistance(List<String> locationTexts) async {
    List<Map<String, dynamic>> locationsWithDistances = [];

    // Geocode each text location
    for (String locationText in locationTexts) {
      try {
        // Use geocoding to get coordinates from the text location
        List<Location> locations = await locationFromAddress(locationText);
        if (locations.isNotEmpty) {
          double lat = locations.first.latitude;
          double lng = locations.first.longitude;

          // Calculate distance
          double distance = _calculateDistance(
            _currentPosition.latitude,
            _currentPosition.longitude,
            lat,
            lng,
          );

          // Add to the list with the original text and calculated distance
          locationsWithDistances.add({
            'location': locationText,
            'distance': distance,
          });
        }
      } catch (e) {
        print('Error retrieving coordinates for $locationText: $e');
      }
    }

    return locationsWithDistances;
  }

  Future<List<Map<String, dynamic>>> sortLocationsByDistance(List<String> locationTexts) async {
    List<Map<String, dynamic>> locationsWithDistances = [];

    // Geocode each text location
    for (String locationText in locationTexts) {
      try {
        // Use geocoding to get coordinates from the text location
        List<Location> locations = await locationFromAddress(locationText);
        if (locations.isNotEmpty) {
          double lat = locations.first.latitude;
          double lng = locations.first.longitude;

          // Calculate distance
          double distance = _calculateDistance(
            _currentPosition.latitude,
            _currentPosition.longitude,
            lat,
            lng,
          );

          // Add to the list with the original text and calculated distance
          locationsWithDistances.add({
            'location': locationText,
            'distance': distance,
          });
        }
      } catch (e) {
        print('Error retrieving coordinates for $locationText: $e');
      }
    }

    // Sort locations by distance
    locationsWithDistances.sort((a, b) => a['distance'].compareTo(b['distance']));

    return locationsWithDistances;
  }

  Future<List<Hotel>> sortHotelsByDistance(List<Hotel> hotels) async {
    // List to store hotels along with calculated distances
    List<Map<String, dynamic>> hotelsWithDistances = [];

    for (Hotel hotel in hotels) {
      try {
        // Geocode each hotel's address
        List<Location> locations = await locationFromAddress("${hotel.address}, ${hotel.district?.districtName}, ${hotel.district?.city?.cityName}");
        if (locations.isNotEmpty) {
          double hotelLat = locations.first.latitude;
          double hotelLng = locations.first.longitude;

          // Calculate distance
          double distance = _calculateDistance(
            _currentPosition.latitude,
            _currentPosition.longitude,
            hotelLat,
            hotelLng,
          );

          hotelsWithDistances.add({
            'hotel': hotel,
            'distance': distance,
          });
        }
      } catch (e) {
        print('Error retrieving coordinates for "${hotel.address}, ${hotel.district?.districtName}, ${hotel.district?.city?.cityName}": $e');
      }
    }

    // Sort hotels by distance
    hotelsWithDistances.sort((a, b) => a['distance'].compareTo(b['distance']));

    // Extract sorted hotels
    List<Hotel> sortedHotels = hotelsWithDistances.map<Hotel>((entry) => entry['hotel']).toList();

    return sortedHotels;
  }
  //Use Haversine to calculate distance
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radius of the Earth in km
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in km
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
