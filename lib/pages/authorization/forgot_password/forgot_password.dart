import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vacod/pages/authorization/login/login.dart';
import 'package:vacod/pages/templates/auth/authorization.dart';
import 'package:vacod/utils/app_dimension.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/utils/style_docoration.dart';
import 'package:vacod/widgets/default_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);
  static const route = '/forgot_password';
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthorizationTemplate(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 44,
              left: AppDimension.s30,
              right: AppDimension.s30,
              bottom: AppDimension.s15,
            ),
            child: Text(
              'Lấy lại mật khẩu',
              style: TextStyles.h2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Điền email để lấy lại mật khẩu',
              style: TextStyles.h3,
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: TextFormField(
                decoration:
                    InputDecorTheme.textFieldStyle(hintTextStr: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (value.isEmpty) return 'Email không được để trống';
                  if (!emailValid) return 'Email không hợp lệ';
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: DefaultButton(
              width: double.infinity,
              widget: Text(
                'Lấy lại mật khẩu',
                style: TextStyles.bodyS16.copyWith(color: lightPrimaryColor),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Đã nhớ mật khẩu?',
                    style: TextStyles.bodyS16,
                  ),
                  TextSpan(
                    text: '  Đăng nhập',
                    style: TextStyles.bodyS16.copyWith(
                      color: lightBlueColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed(LoginPage.route);
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
