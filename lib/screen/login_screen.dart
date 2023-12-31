import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potenday/screen/Start_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void getUserinfo() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        print('name = ${googleUser.displayName}');
        print('email = ${googleUser.email}');
        print('id = ${googleUser.id}');
        String name;
        name = googleUser.displayName!;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => StartScreen(str: name),
        ));
      }
    } catch (error) {
      print('Google Sign-In failed: $error');
    }
  }

  Widget googleSignInButton() {
    return GestureDetector(
      onTap: () {
        signInWithGoogle();
      },
      child: Container(
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 0.0),
              child: Image.asset(
                'assets/images/google.png',
                width: 30,
                height: 30,
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Google 로그인',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Align(
              alignment: AlignmentDirectional(-0.80, -0.40),
              child: Text(
                '메세지 고민 끝,\n구구절절에서 간편하게\n메시지를 작성해보세요!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(-0.83, -0.13),
              child: Text(
                '3초 가입으로 바로 시작해보세요',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.4),
              child: GestureDetector(
                onTap: () async {
                  if (await isKakaoTalkInstalled()) {
                    try {
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      String name;
                      User user = await UserApi.instance.me();
                      if (user.kakaoAccount != null) {
                        name = user.kakaoAccount!.profile!.nickname!;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => StartScreen(str: name),
                        ));
                      }
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        getUserinfo();
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print(await UserApi.instance.accessTokenInfo());
                      getUserinfo();
                      String name;
                      User user = await UserApi.instance.me();
                      if (user.kakaoAccount != null) {
                        name = user.kakaoAccount!.profile!.nickname!;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => StartScreen(str: name),
                        ));
                      }
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                },
                child: Image.asset(
                  'assets/images/kakao.png',
                  width: 400,
                  height: 100,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.6),
              child: googleSignInButton(),
            ),
          ],
        ),
      ),
    );
  }
}
