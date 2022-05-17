/// A data class for when we want to call fetch list products send the pageNumber that we want

class ListProductsRequest{

  final int page;
  // final String searchText;

  ListProductsRequest({
    required this.page,
    // required this.searchText
  });

  Map<String, dynamic> toMap() => {
    "page": page,
    // "": password,
  };

}