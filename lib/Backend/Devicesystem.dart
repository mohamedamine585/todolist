import 'package:connectivity/connectivity.dart';

class Devicesystem {
  Future<bool> check_coonection() async {
    try {
      ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {}
    return false;
  }
}
