import 'package:flutter/material.dart';
import 'package:potenday/screen/Reason_screen.dart';
import 'package:provider/provider.dart';
import 'package:potenday/main.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  int selectedTargetIndex = -1;
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();

  void navigateToReasonScreen(BuildContext context, String target) {
    GlobalStore globalStore = Provider.of<GlobalStore>(context, listen: false);
    globalStore.arr[3] = target;
    print(globalStore.arr);

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        selectedTargetIndex = -1;
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const ReasonScreen(),
      ));
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
          if (label == '기타') {
          } else {
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
                '누구에게 메시지를 보내시나요?',
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
                          0.25 * (i - 2.6),
                        ),
                      if (selectedTargetIndex ==
                          options.indexWhere((option) => option.label == '기타'))
                        Align(
                          alignment: AlignmentDirectional(
                              0.0, 0.15 * (options.length - 0.3)),
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
                                // Save the value or perform any action
                                print('Submitted: $value');
                                if (value != '') {
                                  textEditingController.clear();
                                  navigateToReasonScreen(context, value);
                                }
                                // You can call your save function here
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
                              0.0, 0.15 * (options.length - 0.3)),
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

  const Option({required this.label});
}

final List<Option> options = [
  const Option(label: '💼 현 직장 상사'),
  const Option(label: '📰 전 직장 상사'),
  const Option(label: '🏢 협력 업체'),
  const Option(label: '🧑‍🏫 교수님'),
  const Option(label: '👔 현직자'),
  const Option(label: '기타'),
];
