import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoading({String? msg}) {
  EasyLoading.show(status: msg ?? "加载中...");
}

void dismissLoading() {
  EasyLoading.dismiss();
}
