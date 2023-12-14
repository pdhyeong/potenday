import 'package:flutter/material.dart';
import 'package:potenday/screen/Target_screen.dart';
import 'package:provider/provider.dart';
import 'package:potenday/main.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  void handleButtonPressed(BuildContext context, String channel) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    globalStore.arr[2] = channel;
    print(globalStore.arr);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TargetScreen(),
    ));
  }

  ElevatedButton buildChannelButton(
      BuildContext context, String label, String channel) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        fixedSize: const Size(361, 45),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => handleButtonPressed(context, channel),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
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
            Align(
              alignment: const AlignmentDirectional(-0.9, -0.9),
              child: Image.asset(
                'assets/images/logo_filled.png',
                width: 70,
                height: 50,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, 0.4),
              child: buildChannelButton(context, '💛카카오톡', '카카오톡'),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, 0.55),
              child: buildChannelButton(context, '💬문자', '문자'),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, 0.7),
              child: buildChannelButton(context, '📧이메일', '이메일'),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, 0.85),
              child: buildChannelButton(context, '기타(협업툴)', '협업툴'),
            ),
            const Align(
              alignment: AlignmentDirectional(-0.70, -0.40),
              child: Text(
                '어떤 채널로 전송할까요?',
                style: TextStyle(
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
