class MyNetworkService {
  MyNetworkService._internal();
  static final MyNetworkService _instance = MyNetworkService._internal();
  factory MyNetworkService() => _instance;

  int count = 0;
  show() {
    print("$count");
    count++;
  }
}
