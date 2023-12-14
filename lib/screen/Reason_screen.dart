import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:potenday/screen/SubReason_screen.dart';
import 'package:potenday/main.dart';

class ReasonScreen extends StatelessWidget {
  const ReasonScreen({Key? key}) : super(key: key);

  void _navigateToReasonScreen(BuildContext context, String target) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    globalStore.arr[4] = target;
    print(globalStore.arr);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const SubReasonScreen(),
    ));
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기타'),
        content: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(labelText: '기타 입력'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              String enteredText = textEditingController.text.trim();
              if (enteredText.isNotEmpty) {
                GlobalStore globalStore =
                    Provider.of<GlobalStore>(context, listen: false);
                globalStore.arr[3] = enteredText;
                print(globalStore.arr);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const ReasonScreen(),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('입력된 텍스트가 없습니다.'),
                  ),
                );
              }
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context, String label, String target,
      double verticalPosition) {
    return Align(
      alignment: AlignmentDirectional(0.00, verticalPosition),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          fixedSize: const Size(361, 45),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: label == '기타'
            ? () => _showInputDialog(context)
            : () => _navigateToReasonScreen(context, target),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
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
            for (var i = 0; i < options.length; i++)
              _buildElevatedButton(
                  context, options[i].label, options[i].target, 0.15 * (i + 1)),
            const Align(
              alignment: AlignmentDirectional(-0.70, -0.40),
              child: Text(
                '무슨 이유로 메시지를 보내시나요?',
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

class Option {
  final String label;
  final String target;

  const Option({required this.label, required this.target});
}

final List<Option> options = [
  const Option(label: '👋안부', target: '👋안부'),
  const Option(label: '🎉 축하', target: '🎉 축하'),
  const Option(label: '🙏 부탁 ', target: '🙏 부탁 '),
  const Option(label: '❓질문', target: '❓질문'),
  const Option(label: '기타', target: '기타'),
];
