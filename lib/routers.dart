import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suixin_app/chat_page.dart';
import 'package:suixin_app/login_page.dart';
import 'package:suixin_app/login_verification_code.dart';
import 'package:suixin_app/main.dart';
import 'package:suixin_app/share_screen.dart';

class AppRouters {
  static Future pushToVerificationCode(BuildContext context, String mobile) {
    return context.push("/mobile-verification-code?mobile=$mobile");
  }

  static Future pushToChat(BuildContext context,
      {required String roleName,
      required String roleId,
      required String rolePic}) {
    return context
        .push("/chat?role_id=$roleId&role_name=$roleName&role_pic=$rolePic");
  }

  static void pushToLogin(BuildContext context) {
    return context.replace("/mobile-login");
  }

  static Future pushToShare(BuildContext context) {
    return context.push("/share");
  }
}

/// The route configuration.
final GoRouter routers = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/mobile-login",
    builder: (context, state) {
      return const MobileLoginPage();
    },
  ),
  GoRoute(
    path: "/mobile-verification-code",
    builder: (context, state) {
      return VerificationCodePage(
        mobile: state.queryParameters["mobile"] ?? "",
      );
    },
  ),
  GoRoute(
    path: "/chat",
    builder: (context, state) {
      return ChatPage(
        roleId: state.queryParameters["role_id"] ?? "",
        roleName: state.queryParameters["role_name"] ?? "",
        rolePic: state.queryParameters["role_pic"] ?? "",
      );
    },
  ),
  GoRoute(
    path: "/share",
    builder: (context, state) {
      return const SharePage();
    },
  ),
  GoRoute(
    path: "/",
    builder: (context, state) {
      return const TestPage();
    },
  )
]);
