import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> checkConnectivity() async {
  final isConnected = await InternetConnectionChecker.instance.hasConnection;
  if (isConnected) {
    return true;
  } else {
    return false;
  }
}
