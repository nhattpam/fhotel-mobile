import 'dart:io';

import 'package:dio/dio.dart';

class ImageService {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api/users/image';

  Future<String> uploadImage(File imageFile) async {

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
      });

      Response response = await Dio().post(_baseUrl, data: formData);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          final imageUrl = responseData['link'] as String?;
          if (imageUrl != null) {
            print("Image uploaded successfully. Link: $imageUrl");
            return imageUrl;  // Return the image URL
          } else {
            throw Exception("No image URL found in response");
          }
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print("Error uploading image. StatusCode: ${response.statusCode}");
        throw Exception("Failed to upload image.");
      }
    } catch (error) {
      print("Error uploading image: $error");
      return "";  // Return an empty string on error
    }
  }
}
