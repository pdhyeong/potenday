//DatePick_screen.dart
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              alignment: AlignmentDirectional(-0.83, -0.1),
              child: Text(
                '3초 가입으로 바로 시작해보세요',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black26),
                  fixedSize: const Size(95, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ));
                },
                child: const Text('건너뛰기',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
