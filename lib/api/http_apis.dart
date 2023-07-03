import 'package:suixin_app/api/beans/message_model.dart';
import 'package:suixin_app/api/http_request.dart';

class HttpApis {
  Future getVerificationCode(String mobile) {
    return Request().get(
        path: "/common/verification-code", queryParameters: {"mobile": mobile});
  }

  Future loginMobile(
      {required String mobile,
      required String verificationCode,
      required String? invitedCode}) {
    return Request().post(path: "/login/mobile", data: {
      "mobile": mobile,
      "verificationCode": verificationCode,
      "invitedCode": invitedCode ?? ""
    });
  }

  Future<MessageInfo?> sendMessage(String content,
      {required String roleId}) async {
    final data = await Request().post(
        path: "/chat/sendMessage",
        data: {"roleId": roleId, "message": content});
    return MessageInfo.fromJson(data);
  }

  Future<List<MessageHistoryItem>?> getHistoryMessage(
      {required String roleId}) async {
    final data = await Request()
        .post(path: "/chat/getMessage", data: {"roleId": roleId});
    if (data is List) {
      return data.map((e) => MessageHistoryItem.fromJson(e)).toList();
    }
    return [];
  }

  Future<HomeData?> getHomeRoles() async {
    final data = await Request().post(path: "/chat/chatHome");
    return HomeData.fromJson(data);
  }

  Future<InvitedInfo?> getInvitedInfo() async {
    final data = await Request().post(path: "/chat/invitePageInfo");
    return InvitedInfo.fromJson(data);
  }
}
