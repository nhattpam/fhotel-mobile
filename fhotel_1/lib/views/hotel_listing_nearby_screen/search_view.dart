import '../../data/models/hotel.dart';

abstract class SearchView {
  void onSearchComplete(List<Hotel> roomTypes);
  void onSearchError(String error);
}