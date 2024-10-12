abstract class ImageView {
  void showLoading();
  void hideLoading();
  void onImageUploadSuccess(String imageUrl);
  void onImageUploadError(String error);
}
