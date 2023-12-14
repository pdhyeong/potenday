import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:potenday/screen/SubReason_screen.dart';
import 'package:potenday/main.dart';

class SubReasonScreen extends StatelessWidget {
  const SubReasonScreen({Key? key}) : super(key: key);

  void _navigateToSubReasonScreen(BuildContext context, String target) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    globalStore.arr[5] = target;
    print(globalStore.arr);
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
                  builder: (_) => const SubReasonScreen(),
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
      double verticalPosition, GlobalStore globalStore) {
    String buttonText = label;

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
            : () => _navigateToSubReasonScreen(context, target),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  List<Option> getOptions(GlobalStore globalStore) {
    switch (globalStore.arr[4]) {
      case '👋 안부':
        return [
          const Option(label: '💙 일상', target: '💙 일상'),
          const Option(label: '😷 건강', target: '😷 건강'),
          const Option(label: '🎄 연말', target: '🎄 연말'),
          const Option(label: '☀️ 연초', target: '☀️ 연초'),
          const Option(label: '🧧 설날', target: '🧧 설날'),
          const Option(label: '🍂 추석', target: '🍂 추석'),
          const Option(label: '기타', target: '기타'),
        ];
      case '🎉 축하':
        return [
          const Option(label: '🎂 생신', target: '🎂 생신'),
          const Option(label: '💍 결혼', target: '💍 결혼'),
          if (globalStore.arr[3] != '🧑‍🏫 교수님')
            const Option(label: '👔 승진', target: '👔 승진'),
          const Option(label: '기타', target: '기타'),
        ];
      case '🙏 부탁':
        return [
          if (globalStore.arr[3] != '🧑‍🏫 교수님')
            const Option(label: '🏖️ 연차 신청', target: '🏖️ 연차 신청'),
          const Option(label: '🗣️ 면담 신청', target: '🗣️ 면담 신청'),
          const Option(label: '🤝 협업 요청', target: '🤝 협업 요청'),
          if (globalStore.arr[3] == '🧑‍🏫 교수님')
            const Option(label: '💯 성적 정정', target: '💯 성적 정정'),
          if (globalStore.arr[3] == '🧑‍🏫 교수님')
            const Option(label: '📆 출결 정정', target: '📆 출결 정정'),
          if (globalStore.arr[3] == '🧑‍🏫 교수님')
            const Option(label: '⭕️ 결석 인정', target: '⭕️ 결석 인정'),
          const Option(label: '📑 추천서', target: '📑 추천서'),
          const Option(label: '기타', target: '기타'),
        ];
      case '❓ 질문':
        return [
          const Option(label: '💼 업무 내용', target: '💼 업무 내용'),
          if (globalStore.arr[3] == '🧑‍🏫 교수님')
            const Option(label: '📚 강의 내용', target: '📚 강의 내용'),
          const Option(label: '👀 개인적인 질문', target: '👀 개인적인 질문'),
          const Option(label: '기타', target: '기타'),
        ];
      default:
        return [];
    }
  }

  String getMessageText(GlobalStore globalStore) {
    switch (globalStore.arr[4]) {
      case '👋 안부':
        return '어떤 안부 연락을 드릴까요?';
      case '🎉 축하':
        return '어떤 축하 연락을 드릴까요?';
      case '🙏 부탁':
        return '어떤 부탁을 드릴까요?';
      case '❓ 질문':
        return '어떤 질문을 드릴까요?';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);

    List<Option> options = getOptions(globalStore);

    String messageText = getMessageText(globalStore);

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
                  1.05 - 0.15 * (options.length - i), globalStore),
            Align(
              alignment: const AlignmentDirectional(-0.70, -0.40),
              child: Text(
                messageText,
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

class Option {
  final String label;
  final String target;

  const Option({required this.label, required this.target});
}
