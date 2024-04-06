import 'package:connectivity_plus/connectivity_plus.dart';

Future<String> verificarConexion() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    return 'conexion';
  } else {
    return 'sin conexion';
  }
}
