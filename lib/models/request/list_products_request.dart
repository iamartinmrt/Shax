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