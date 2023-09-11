// https://cmcrud.herokuapp.com/products

class NetworkAPI {
  // 10.0.2.2 is loop back ip when runin emulator
  static const String baseURL = 'http://10.0.2.2:1150';
  // static const String baseURL = 'https://cmcrud.herokuapp.com'; // 'https://cmcrud.herokuapp.com'
  static const String imageURL = '$baseURL/images';
  static const String product = '/products';
  static const String username = 'username';
  static const String token = 'token';
}
