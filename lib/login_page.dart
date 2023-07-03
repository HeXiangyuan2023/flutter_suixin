
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:suixin_app/api/http_apis.dart';
import 'package:suixin_app/app_colors.dart';
import 'package:suixin_app/common/cookie_manager.dart';
import 'package:suixin_app/common/toast.dart';
import 'package:suixin_app/logger.dart';
import 'package:suixin_app/routers.dart';
import 'package:suixin_app/widgets/loading.dart';

import 'button.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _buildHeader(),
          const SizedBox(
            height: 64,
          ),
          _buildIcons(),
          const SizedBox(
            height: 12,
          ),
          const Text("进行了 384,290,017 次交流"),
          const SizedBox(
            height: 12,
          ),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: "请输入手机号码"),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: RoundedButton(
              text: "获取验证码",
              onPressed: () {
                final phoneRegExp = RegExp(r'^1[3456789]\d{9}$');
                if (!phoneRegExp.hasMatch(_mobileController.text)) {
                  toastError('请输入正确的手机号');
                  return;
                }
                showLoading(msg: "获取中...");
                AppRouters.pushToVerificationCode(
                        context, _mobileController.text)
                    .then((value) {
                  login(context, "13788936717", "123456", "");
                });

                dismissLoading();
                // HttpApis()
                //     .getVerificationCode(_mobileController.text)
                //     .then((value) {
                //   dismissLoading();
                //   AppRouters.pushToVerificationCode(
                //       context, _mobileController.text);
                // }).onError((error, stackTrace) {
                //   dismissLoading();
                //   logger.e("verification $error");
                // });
              },
            ),
          )
        ]),
      ),
    );
  }

  void login(BuildContext context, String mobile, String verificationCode,
      String? invitedCode) async {
    try {
      showLoading(msg: "登录中...");
      final data = await HttpApis().loginMobile(
          mobile: mobile,
          verificationCode: verificationCode,
          invitedCode: invitedCode);
      dismissLoading();
      if (data['cookie'] != null) {
        CookieManager.setCookie(data['cookie']);
        showToast("登录成功");
        logger.d(CookieManager.getCookie());
        if (mounted) {
          context.replace("/");
        }
      } else {
        showToast("登录失败，请稍后重试");
      }
    } catch (e) {
      dismissLoading();
      showToast("登录失败，请稍后重试");
    }
  }

  Widget _buildIcons() {
    return SizedBox(
      width: 220,
      height: 100,
      child: Center(
        child: Stack(
          children: const [
            Positioned(
              left: 0,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/app_logo.png'),
              ),
            ),
            Positioned(
              left: 60,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/app_logo.png'),
              ),
            ),
            Positioned(
              left: 120,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/app_logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.close,
            color: AppColors.light().black,
          ),
        )
      ],
    );
  }
}
