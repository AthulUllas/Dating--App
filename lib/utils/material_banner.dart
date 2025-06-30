import 'package:fluttertoast/fluttertoast.dart';

void banner(String message, int duration) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
  Future.delayed(Duration(seconds: duration), () {
    hideBanner();
  });
}

void hideBanner() {
  Fluttertoast.cancel();
}
