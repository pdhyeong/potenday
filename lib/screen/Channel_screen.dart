import 'package:flutter/material.dart';
import 'package:potenday/screen/Target_screen.dart';
import 'package:provider/provider.dart';
import 'package:potenday/main.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  int selectedChannelIndex = -1;

  void handleButtonPressed(BuildContext context, String channel, int index) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    globalStore.arr[2] = channel;
    print(globalStore.arr);

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        selectedChannelIndex = -1;
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const TargetScreen(),
      ));
    });
  }

  Widget buildChannelButton(BuildContext context, String channel, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedChannelIndex = index;
        });
        handleButtonPressed(context, channel, index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: selectedChannelIndex == index
              ? const Color.fromARGB(255, 255, 210, 48)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedChannelIndex == index
                ? Colors.transparent
                : Colors.black,
            width: 1,
          ),
        ),
        child: Container(
          width: 361,
          height: 45,
          alignment: Alignment.center,
          child: Text(
            channel,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color:
                  selectedChannelIndex == index ? Colors.white : Colors.black,
            ),
          ),
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
            for (var i = 0; i < channels.length; i++)
              Align(
                alignment: AlignmentDirectional(0.00, 0.45 + 0.15 * i),
                child: buildChannelButton(context, channels[i], i),
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

final List<String> channels = ['💛카카오톡', '💬문자', '📧이메일', '기타(협업툴)'];
