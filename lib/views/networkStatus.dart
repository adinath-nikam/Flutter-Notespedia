import 'package:connectivity/connectivity.dart';

checkInternetiConnectivity() async {
  var result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    return false;
  } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
    return true;
  }
}
