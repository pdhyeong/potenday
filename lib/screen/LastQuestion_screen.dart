import 'package:flutter/material.dart';
import 'package:potenday/screen/Reason_screen.dart';
import 'package:provider/provider.dart';
import 'package:potenday/main.dart';

class LastQuestionScreen extends StatelessWidget {
  const LastQuestionScreen({Key? key}) : super(key: key);

  void _navigateToReasonScreen(BuildContext context, String target) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    print(globalStore.arr);
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('더 해주고 싶은 이야기'),
        content: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              String enteredText = textEditingController.text.trim();
              if (enteredText.isNotEmpty) {
                GlobalStore globalStore =
                    Provider.of<GlobalStore>(context, listen: false);
                globalStore.arr[6] = enteredText;
                print(globalStore.arr);
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
        onPressed: label == '🙆 네, 더 있어요'
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
            for (var i = options.length - 1; i >= 0; i--)
              _buildElevatedButton(context, options[i].label, options[i].target,
                  1.05 - 0.15 * (options.length - i)),
            const Align(
              alignment: AlignmentDirectional(-0.70, -0.40),
              child: Text(
                '이야기를 잘 들었어요.\n더 해주고 싶은 이야기가 있나요?',
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
  const Option(label: '🙅 아니요, 다 말했어요', target: '🙅 아니요, 다 말했어요'),
  const Option(label: '🙆 네, 더 있어요', target: '🙆 네, 더 있어요'),
];
