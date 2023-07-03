import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suixin_app/api/beans/message_model.dart';
import 'package:suixin_app/api/http_apis.dart';
import 'package:suixin_app/app_colors.dart';
import 'package:suixin_app/common/toast.dart';
import 'package:suixin_app/typography.dart';
import 'package:suixin_app/widgets/loading.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  InvitedInfo? _invitedInfo = null;

  @override
  void initState() {
    super.initState();
    showLoading();
    HttpApis().getInvitedInfo().then((value) {
      dismissLoading();
      setState(() {
        _invitedInfo = value;
      });
    }).onError((error, stackTrace) {
      dismissLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = "https://www.suixin.com/login?inivted=${_invitedInfo?.invite}";
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Container(
        margin: const EdgeInsets.only(top: 72, left: 12, right: 12),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CircleAvatar(
            child: SizedBox(
                width: 160,
                child: Image.asset(
                  "assets/images/app_logo.png",
                  fit: BoxFit.fill,
                )),
          ),
          const SizedBox(height: 12),
          const Text("随心 AI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Text(
                        "${_invitedInfo?.inviteNum ?? 0}",
                        style: AppTypography.h2(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "累计邀请",
                        style: AppTypography.h2(),
                      )
                    ]),
                    Column(children: [
                      Text(
                        "${_invitedInfo?.inviteStamina ?? 0}",
                        style: AppTypography.h2(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "累计获得",
                        style: AppTypography.h2(),
                      )
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: AppColors.light().backgroundTertiary,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      url,
                      overflow: TextOverflow.ellipsis,
                    )),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: url))
                            .then((value) => showToast("复制成功"));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: AppColors.light().white,
                        ),
                        child: Text("复制链接"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ))
        ]),
      ),
    );
  }
}
