import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/repository/location_service.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/location_view.dart';

import '../core/app_export.dart';

class LocationPresenter {
  final LocationView view;

  LocationPresenter(this.view);

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
    } else if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    await getAddressFromLatLng(position);
  }

  Future<void> calculateDistance(List<Hotel> listHotels) async {
    // Get the current position of the user
    Position position = await Geolocator.getCurrentPosition();

    LocationService locationService =
        LocationService(position); // Pass current position

    List<String> hotelAddresses = listHotels
        .map((hotel) =>
            "${hotel.address}, ${hotel.district?.districtName}, ${hotel.district?.city?.cityName}")
        .toList();

    List<Map<String, dynamic>> sortedLocations =
        await locationService.LocationsByDistance(hotelAddresses);
    // Update state with the current position

    List<String> distance = sortedLocations.map<String>((entry) {
      return entry['distance'].toStringAsFixed(2); // Format to 2 decimal places
    }).toList(); // Convert Iterable to List
    view.updateDistance(distance);

    // Get the address from the current position
    await getAddressFromLatLng(position);
  }

  // Future<void> sortDistance(List<Hotel> listHotel, bool sortByClosest) async {
  //   // Get the current position of the user
  //   Position position = await Geolocator.getCurrentPosition();
  //   LocationService locationService = LocationService(position); // Pass current position
  //
  //   // Get hotel addresses as a list of strings
  //   List<String> hotelAddresses = listHotel.map((hotel) => "${hotel.address}, ${hotel.district?.districtName}, ${hotel.district?.city?.cityName}").toList();
  //   List<Map<String, dynamic>> sortedLocations = await locationService.sortLocationsByDistance(hotelAddresses);
  //   List<Hotel> sortedHotels = await locationService.sortHotelsByDistance(listHotel);
  //
  //   // Reverse if sorting by farthest
  //   if (!sortByClosest) {
  //     sortedLocations = sortedLocations.reversed.toList();
  //     sortedHotels = sortedHotels.reversed.toList();
  //   }
  //
  //     // Extract distances from sortedLocations
  //   List<String> distance = sortedLocations.map<String>((entry) {
  //       return entry['distance'].toStringAsFixed(2); // Format to 2 decimal places
  //     }).toList();
  //
  //   view.updateHotel(sortedHotels);
  //   view.updateDistance(distance);
  //   // Get the address from the current position
  //   await getAddressFromLatLng(position);
  // }

  Future<void> sortDistance(List<Hotel> listHotel, bool sortByClosest, {List<String>? existingDistances}) async {
    List<Hotel> sortedHotels;
    List<String> distance;

    if (existingDistances != null && existingDistances.isNotEmpty) {
      // Sort using the existing distances
      List<Map<String, dynamic>> hotelsWithDistances = [];
      for (int i = 0; i < listHotel.length; i++) {
        hotelsWithDistances.add({
          'hotel': listHotel[i],
          'distance': double.parse(existingDistances[i]),
        });
      }

      // Sort by distance
      hotelsWithDistances.sort((a, b) => a['distance'].compareTo(b['distance']));

      // Reverse if sorting by farthest
      if (!sortByClosest) {
        hotelsWithDistances = hotelsWithDistances.reversed.toList();
      }

      // Extract sorted hotels and distances
      sortedHotels = hotelsWithDistances.map<Hotel>((entry) {
        return entry['hotel'] as Hotel; // Cast to Hotel if necessary
      }).toList();

      distance = hotelsWithDistances.map<String>((entry) {
        return entry['distance'].toStringAsFixed(2); // Convert to String and format
      }).toList();
    } else {
      // Perform the original distance calculation logic
      Position position = await Geolocator.getCurrentPosition();
      LocationService locationService = LocationService(position);

      List<Map<String, dynamic>> sortedLocations = await locationService.sortLocationsByDistance(
          listHotel.map((hotel) => "${hotel.address}, ${hotel.district?.districtName}, ${hotel.district?.city?.cityName}").toList()
      );

      sortedHotels = await locationService.sortHotelsByDistance(listHotel);

      // Reverse if sorting by farthest
      if (!sortByClosest) {
        sortedLocations = sortedLocations.reversed.toList();
        sortedHotels = sortedHotels.reversed.toList();
      }

      // Extract distances from sorted locations
      distance = sortedLocations.map<String>((entry) => entry['distance'].toStringAsFixed(2)).toList();
    }

    // Update the view with the sorted hotels and distances
    view.updateHotel(sortedHotels);
    view.updateDistance(distance);
  }


  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        view.updateAddress(
            '${place.subAdministrativeArea} ${place.administrativeArea}');
      } else {
        print('No address found for this location.');
      }
    } catch (e) {
      print('Error retrieving address: $e');
    }
  }
}
