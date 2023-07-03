import 'package:toast/toast.dart';

void showToast(String msg, {int? duration, int? gravity}) {
  Toast.show(msg, duration: duration, gravity: gravity);
}

void toastError(String msg, {int? duration, int? gravity}) {
  showToast(msg, duration: duration, gravity: gravity);
}
