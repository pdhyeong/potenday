import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:potenday/screen/SubReason_screen.dart';
import 'package:potenday/screen/LastQuestion_screen.dart';
import 'package:potenday/main.dart';

// ... (previous imports and code)

class ReasonScreen extends StatefulWidget {
  const ReasonScreen({Key? key}) : super(key: key);

  @override
  _ReasonScreenState createState() => _ReasonScreenState();
}

class _ReasonScreenState extends State<ReasonScreen> {
  int selectedTargetIndex = -1;
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();

  void navigateToReasonScreen(BuildContext context, String target) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    globalStore.arr[4] = target;
    print(globalStore.arr);
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        selectedTargetIndex = -1;
      });
      if (target == '👋 안부' ||
          target == '🎉 축하' ||
          target == '🙏 부탁' ||
          target == '❓ 질문') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const SubReasonScreen(),
        ));
      } else {
        globalStore.arr[5] = "";
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const LastQuestionScreen(),
        ));
      }
    });
  }

  Widget buildElevatedButton(
      BuildContext context, String label, double verticalPosition) {
    return Align(
      alignment: AlignmentDirectional(0.00, verticalPosition),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTargetIndex = options.indexWhere(
              (option) => option.label == label,
            );
          });
          if (label != '기타') {
            navigateToReasonScreen(context, label);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: selectedTargetIndex ==
                    options.indexWhere(
                      (option) => option.label == label,
                    )
                ? const Color.fromARGB(255, 255, 210, 48)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedTargetIndex ==
                      options.indexWhere(
                        (option) => option.label == label,
                      )
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
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: selectedTargetIndex ==
                        options.indexWhere(
                          (option) => option.label == label,
                        )
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  16.0, 140.0, 16.0, 16.0), // Adjust the top padding value
              child: Text(
                '무슨 이유로 메시지를 보내시나요?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      256, // Adjusted height
                  child: Stack(
                    children: [
                      for (var i = 0; i < options.length; i++)
                        buildElevatedButton(
                          context,
                          options[i].label,
                          0.25 * (i - 1.5),
                        ),
                      if (selectedTargetIndex ==
                          options.indexWhere((option) => option.label == '기타'))
                        Align(
                          alignment: AlignmentDirectional(
                              0.0, 0.15 * (options.length + 0.7)),
                          child: Container(
                            width: 361,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              autofocus: true,
                              controller: textEditingController,
                              focusNode: textFieldFocus,
                              onSubmitted: (value) {
                                print('Submitted: $value');
                                if (value != '') {
                                  textEditingController.clear();
                                  navigateToReasonScreen(context, value);
                                }
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                      if (selectedTargetIndex ==
                          options.indexWhere((option) => option.label == '기타'))
                        const Align(
                          alignment: AlignmentDirectional(0.0, 0.05),
                        )
                      else
                        Align(
                          alignment: AlignmentDirectional(
                              0.0, 0.15 * (options.length + 0.7)),
                          child: Container(
                            width: 361,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      if (selectedTargetIndex ==
                          options.indexWhere((option) => option.label == '기타'))
                        const Align(
                          alignment: AlignmentDirectional(0.0, 0.05),
                        )
                      else
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textFieldFocus.dispose();
    super.dispose();
  }
}

class Option {
  final String label;

  const Option({required this.label}) : assert(label != '');
}

final List<Option> options = [
  const Option(label: '👋 안부'),
  const Option(label: '🎉 축하'),
  const Option(label: '🙏 부탁'),
  const Option(label: '❓ 질문'),
  const Option(label: '기타'),
];
