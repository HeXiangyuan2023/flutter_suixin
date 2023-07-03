import 'dart:html';

class CookieManager {
  static setCookie(String cookie) {
    document.cookie = "suixin-cookie=$cookie";
  }

  static String? getCookie() {
    try {
      final cookie = document.cookie!;
      final entity = cookie.split("; ");
      String? myToken;
      for (int i = 0; i < entity.length; i++) {
        if (entity[i].startsWith("suixin-cookie=")) {
          myToken = entity[i].replaceFirst("suixin-cookie=", "");
          break;
        }
      }
      return myToken;
    } catch (e) {
      return null;
    }
  }
}

class UserManager {
  bool isLogin() {
    return CookieManager.getCookie() != null;
  }
}
