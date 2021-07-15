import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/authorization/login/login.dart';
import 'package:vacod/pages/templates/auth/authorization.dart';
import 'package:vacod/providers/sign_up.dart';
import 'package:vacod/utils/app_dimension.dart';
import 'package:vacod/utils/app_icons.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/utils/style_docoration.dart';
import 'package:vacod/widgets/default_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const route = '/signUp';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
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
              'Hãy đăng ký nào',
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
          _buildSocialButton(),
          SizedBox(height: 30),
          _buildFormSignUp(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: DefaultButton(
              width: double.infinity,
              widget: Text(
                'Đăng ký',
                style: TextStyles.bodyS16.copyWith(color: lightPrimaryColor),
              ),
              onPressed: () {
                // if (formKey.currentState.validate()) {
                //   Provider.of<SignUpProvider>(context, listen: false)
                //       .signUp(_username.text, _email.text, _password.text);
                // }
              },
            ),
          ),
          SizedBox(height: 36),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Đã có tài khoản?',
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildFormSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _username,
              decoration:
                  InputDecorTheme.textFieldStyle(hintTextStr: 'Tài khoản'),
              validator: (value) {
                if (value!.isEmpty) return 'Tài khoản không được để trống';
                if (value.length < 8) return 'Tài khoản phải >= 8 ký tự';
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _email,
              decoration: InputDecorTheme.textFieldStyle(hintTextStr: 'Email'),
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
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _password,
              decoration:
                  InputDecorTheme.textFieldStyle(hintTextStr: 'Mật khẩu'),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) return 'Mật khẩu không được để trống';
                if (value.length < 8) return 'Mật khẩu phải >= 8 ký tự';
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSocialButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultButton(
            width: 147.5,
            widget: SizedBox(
              height: 21,
              width: 76,
              child: AppIcons.googleLink,
            ),
            onPressed: () {},
            buttonColor: lightRedColor,
          ),
          DefaultButton(
            width: 147.5,
            widget: SizedBox(
              height: 21,
              width: 76,
              child: AppIcons.fbLink,
            ),
            onPressed: () {},
            buttonColor: lightBlueColor,
          ),
        ],
      ),
    );
  }
}
