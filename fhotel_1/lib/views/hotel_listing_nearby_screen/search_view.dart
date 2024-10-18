import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/search.dart';

abstract class SearchView {
  void onSearchComplete(List<RoomType> roomTypes);
  void onSearchError(String error);
}