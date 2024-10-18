import 'package:fhotel_1/data/models/search.dart';
import 'package:fhotel_1/data/repository/search_service.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/search_view.dart';

class SearchPresenter {
  final SearchView view;
  final SearchService searchService;

  SearchPresenter(this.view, this.searchService);

  // Future<void> searchRoomTypes(
  //     String? roomTypeName,
  //     int quantity,
  //     String? cityName) async {
  //   try {
  //     final roomTypes = await searchService.searchRoomTypes(
  //         roomTypeName, quantity, cityName);
  //     view.onSearchComplete(roomTypes);
  //   } catch (error) {
  //     view.onSearchError(error.toString());
  //   }
  // }
  Future<void> searchListRoomTypes(List<RoomSearchRequest> searchRequests, String? cityName) async {
    try {
      final roomTypes = await searchService.searchListRoomTypes(searchRequests, cityName);
      print(roomTypes);
      view.onSearchComplete(roomTypes);
    } catch (error) {
      view.onSearchError(error.toString());
    }
  }
}