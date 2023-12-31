import 'package:flutter/material.dart';
import 'package:potenday/screen/Channel_screen.dart';

class StartScreen extends StatelessWidget {
  final String str;
  const StartScreen({required this.str, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(-0.9, -0.9),
              child: Image.asset(
                'assets/images/logo_filled.png',
                width: 70,
                height: 50,
              ),
            ),
            Align(
                alignment: const AlignmentDirectional(0.00, 0.3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 255, 210, 48),
                    fixedSize: const Size(361, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ChannelScreen(),
                    ));
                  },
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
            Align(
              alignment: const AlignmentDirectional(-0.60, -0.40),
              child: Text(
                '안녕하세요! $str님\n메세지 작성을 도와드릴까요?',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(0.0, 0.05),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
