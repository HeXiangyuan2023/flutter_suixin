import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suixin_app/common/cookie_manager.dart';

class UserInfo {
  final String? token;

  final String? mobile;

  final int? stamina;

  final String? invitedCode;

  UserInfo(this.token, this.mobile, this.stamina, this.invitedCode);
}

class UserInfoState extends StateNotifier<UserInfo> {
  UserInfoState(super.state);

  login(String token, String mobile) {
    state = UserInfo(token, mobile, state.stamina, state.invitedCode);
  }

  setStamina(int stamina) {
    state = UserInfo(state.token, state.mobile, stamina, state.invitedCode);
  }

  setInvitedCode(String invitedCode) {
    state = UserInfo(state.token, state.mobile, state.stamina, invitedCode);
  }
}

final userInfoProvider = StateNotifierProvider<UserInfoState, UserInfo>((ref) =>
    UserInfoState(UserInfo(CookieManager.getCookie(), null, null, null)));
