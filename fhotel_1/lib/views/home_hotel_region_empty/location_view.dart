import 'package:fhotel_1/data/models/hotel.dart';

import '../../core/app_export.dart';

abstract class LocationView {
  void updatePosition(Position position);
  void updateAddress(String address);
  void updateDistance(List<String> distances);
  void updateHotel(List<Hotel> hotels);
}
