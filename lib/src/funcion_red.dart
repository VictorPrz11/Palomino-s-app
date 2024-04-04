import 'package:connectivity_plus/connectivity_plus.dart';

Future<String> conectividad() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return 'conexion mobile';
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return 'conexion wifi';
  } else {
    return 'Sin conexion';
  }
}
