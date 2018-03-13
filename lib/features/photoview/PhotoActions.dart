class FetchImagesAction {
  FetchImagesAction(this.page);

  final int page;
}
class FetchResultImagesAction {
  FetchResultImagesAction(this.images, this.page);

  final List<String> images;
  final int page;
}
class CancelFetchImagesAction { }

