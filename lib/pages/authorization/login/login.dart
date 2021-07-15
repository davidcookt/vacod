import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/authorization/forgot_password/forgot_password.dart';
import 'package:vacod/pages/authorization/sign_up/sign_up.dart';
import 'package:vacod/pages/templates/auth/authorization.dart';
import 'package:vacod/providers/login.dart';
import 'package:vacod/utils/app_dimension.dart';
import 'package:vacod/utils/colors.dart';
import 'package:vacod/utils/style_docoration.dart';
import 'package:vacod/widgets/default_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
              'Hãy đăng nhập nào',
              style: TextStyles.h2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Chào mừng bạn quay trở lại',
              style: TextStyles.h3,
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _email,
                    decoration: InputDecorTheme.textFieldStyle(
                        hintTextStr: 'Tài khoản'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tài khoản không được để trống';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration:
                        InputDecorTheme.textFieldStyle(hintTextStr: 'Mật khẩu'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: DefaultButton(
              width: double.infinity,
              widget: Text(
                'Đăng nhập',
                style: TextStyles.bodyS16.copyWith(color: lightPrimaryColor),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print(_email.text);
                  Provider.of<LoginProvider>(context, listen: false)
                      .login(_email.text, _password.text);
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ForgotPasswordPage.route);
              },
              child: Text(
                'Quên mật khẩu?',
                style: TextStyles.bodyS16.copyWith(
                  color: lightBlueColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Không có tài khoản?',
                    style: TextStyles.bodyS16,
                  ),
                  TextSpan(
                    text: '  Đăng ký',
                    style: TextStyles.bodyS16.copyWith(
                      color: lightBlueColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed(SignUpPage.route);
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
