import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';
import 'package:suixin_app/typography.dart';

import 'app_colors.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key, required this.mobile});
  final String mobile;

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  bool _onEditing = true;
  String? _code;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('验证码已发送', style: AppTypography.h1()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child:
                    Text('验证码已发送 ${widget.mobile}', style: AppTypography.h4()),
              ),
            ),
            VerificationCode(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.number,
              underlineColor: Colors.amber,
              length: 4,
              cursorColor: Colors.blue,
              clearAll: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '重新输入',
                  style: TextStyle(
                      fontSize: 14.0,
                      decoration: TextDecoration.underline,
                      color: Colors.blue[700]),
                ),
              ),
              margin: const EdgeInsets.all(12),
              onCompleted: (String value) {
                context.pop(value);
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
