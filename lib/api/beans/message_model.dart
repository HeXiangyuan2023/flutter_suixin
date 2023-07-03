class MessageInfo {
  int? roleId;
  String? answer;
  int? stamina;

  MessageInfo({this.roleId, this.answer, this.stamina});

  MessageInfo.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    answer = json['answer'];
    stamina = json['stamina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roleId'] = roleId;
    data['answer'] = answer;
    data['stamina'] = stamina;
    return data;
  }
}

class MessageHistoryItem {
  int? id;
  int? userId;
  String? role;
  String? content;
  int? virtualRoleId;
  int? time;
  int? status; //1 历史消息  2 请求中

  MessageHistoryItem(
      {this.id,
      this.userId,
      this.role,
      this.content,
      this.virtualRoleId,
      this.time,
      this.status = 1});

  MessageHistoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    role = json['role'];
    content = json['content'];
    virtualRoleId = json['virtualRoleId'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['role'] = role;
    data['content'] = content;
    data['virtualRoleId'] = virtualRoleId;
    data['time'] = time;
    return data;
  }
}

class Chat {
  int? id;
  int? userId;
  String? role;
  String? content;
  int? virtualRoleId;
  int? time;

  Chat(
      {this.id,
      this.userId,
      this.role,
      this.content,
      this.virtualRoleId,
      this.time});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    role = json['role'];
    content = json['content'];
    virtualRoleId = json['virtualRoleId'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['role'] = role;
    data['content'] = content;
    data['virtualRoleId'] = virtualRoleId;
    data['time'] = time;
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? pic;
  Chat? chat;

  Role({this.id, this.name, this.pic, this.chat});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pic = json['pic'];
    chat = json['chat'] != null ? Chat?.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['pic'] = pic;
    data['chat'] = chat!.toJson();
    return data;
  }
}

class HomeData {
  int? stamina; // 体力值
  List<Role>? roles;

  HomeData({this.stamina, this.roles});

  HomeData.fromJson(Map<String, dynamic> json) {
    stamina = json['stamina'];
    if (json['roles'] != null) {
      roles = <Role>[];
      json['roles'].forEach((v) {
        roles!.add(Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stamina'] = stamina;
    data['roles'] =
        roles != null ? roles!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}


/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class InvitedInfo {
    int? stamina;
    int? inviteNum;
    int? inviteStamina;
    String? invite;

    InvitedInfo({this.stamina, this.inviteNum, this.inviteStamina, this.invite}); 

    InvitedInfo.fromJson(Map<String, dynamic> json) {
        stamina = json['stamina'];
        inviteNum = json['inviteNum'];
        inviteStamina = json['inviteStamina'];
        invite = json['invite'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['stamina'] = stamina;
        data['inviteNum'] = inviteNum;
        data['inviteStamina'] = inviteStamina;
        data['invite'] = invite;
        return data;
    }
}

