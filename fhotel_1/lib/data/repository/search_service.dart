import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/user.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/search.dart';

class SearchService {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<bool> checkEmailExistence({String? query}) async {
    var data = <Map<String, dynamic>>[];
    List<User> results = [];
    final url = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body).cast<Map<String, dynamic>>();
        results = data.map((e) => User.fromJson(e)).toList();
        if (query != null) {
          results = results.where((element) => element.email != null && element.email!.toLowerCase() == query.toLowerCase()).toList();
          if(results.isNotEmpty){
            return true;
          }else{
            return false;
          }
        }
        return false;
        // Indicates successful operation
      } else {
        print("fetch error");
      }
    } catch (e) {
      print('error: $e');
    }
    return false; // Indicates failure
  }
  Future<bool> checkIdNumberExistence({String? query}) async {
    var data = <Map<String, dynamic>>[];
    List<User> results = [];
    final url = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body).cast<Map<String, dynamic>>();
        results = data.map((e) => User.fromJson(e)).toList();
        if (query != null) {
          results = results.where((element) => element.identificationNumber != null && element.identificationNumber!.toLowerCase() == query.toLowerCase()).toList();
          if(results.isNotEmpty){
            return true;
          }else{
            return false;
          }
        }
        return false;
        // Indicates successful operation
      } else {
        print("fetch error");
      }
    } catch (e) {
      print('error: $e');
    }
    return false; // Indicates failure
  }
  Future<bool> checkPhoneNumberExistence({String? query}) async {
    var data = <Map<String, dynamic>>[];
    List<User> results = [];
    final url = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body).cast<Map<String, dynamic>>();
        results = data.map((e) => User.fromJson(e)).toList();
        if (query != null) {
          results = results.where((element) => element.phoneNumber != null && element.phoneNumber!.toLowerCase() == query.toLowerCase()).toList();
          if(results.isNotEmpty){
            return true;
          }else{
            return false;
          }
        }
        return false;
        // Indicates successful operation
      } else {
        print("fetch error");
      }
    } catch (e) {
      print('error: $e');
    }
    return false; // Indicates failure
  }
  Future<bool> checkPasswordExistence({String? query}) async {
    final customerId = SessionManager().getUserId();
    final url = Uri.parse('$_baseUrl/users/$customerId');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        // Parse the user from the JSON response
        User user = User.fromJson(responseData);

        // Check if query matches the user's password
        if (query != null && user.password != null) {
          return user.password!.toLowerCase() == query.toLowerCase();
        }
      } else {
        print("Fetch error: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
    }
    return false; // Indicates failure
  }

  Future<List<Hotel>> searchListRoomTypes(
      List<RoomSearchRequest> searchRequests, String? cityName) async {
    final url = Uri.parse('$_baseUrl/room-types/search?query=${cityName ?? ""}');
    print(url);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(searchRequests.map((e) => e.toJson()).toList()),
    );
    // print("Response body: ${response.body}");  // Print the error message
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print("Search Total Result:" + body.toString());
      return body.map((dynamic item) =>
          Hotel.fromJson(item))
          .where((room) => room.isActive == true)
          .toList();
    } else {
      throw Exception('Failed to load hotel');
    }
  }
}