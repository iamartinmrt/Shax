class ApiConstants{
  static const String baseUrl = "http://192.168.45.20:8000";
  // static const String baseUrl = "http://192.168.1.134:8000";
  static const String userToken = "userToken";
  static const String fetchInitCallUrl = "/init_call/";
  static const String callLoginAuthUrl = "/user/signin/";
  static const String callUpdateUserUrl = "/user/update/";
  static const String callSignupAuthUrl = "/user/signup/";
  static const String fetchListProductsUrl = "/product/product/";
  static const String callCreateProductUrl = "/product/product/";
  static const String callDeleteProductUrl = "/product/delete_product/";
  static const int connectTimeoutDuration = 5000;
  static const int receiveTimeoutDuration = 5000;
}