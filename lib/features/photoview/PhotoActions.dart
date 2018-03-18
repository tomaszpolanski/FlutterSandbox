class FetchImagesAction {
  FetchImagesAction(this.page);

  final int page;

  bool operator ==(o) => o is FetchImagesAction && page == o.page;

  int get hashCode => page;
}

class FetchResultImagesAction {
  FetchResultImagesAction(this.images, this.page);

  final List<String> images;
  final int page;
}

class CancelFetchImagesAction {}

