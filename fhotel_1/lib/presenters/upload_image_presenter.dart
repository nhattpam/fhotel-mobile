import 'dart:io';
import 'package:fhotel_1/data/repository/upload_image_service.dart';

import '../views/register_fill_information/upload_image_view.dart';

class ImagePresenter {
  final ImageView _view;
  final ImageService _imageService;

  ImagePresenter(this._view, this._imageService);

  Future<void> pickImageAndUpload(File imageFile) async {
    try {
      _view.showLoading();
      String imageUrl = await _imageService.uploadImage(imageFile);
      _view.onImageUploadSuccess(imageUrl);
    } catch (error) {
      _view.onImageUploadError(error.toString());
    } finally {
      _view.hideLoading();
    }
  }
}
