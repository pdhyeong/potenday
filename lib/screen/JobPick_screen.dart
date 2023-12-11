import 'package:flutter/material.dart';
import 'package:potenday/screen/login_screen.dart';

class JobPickScreen extends StatefulWidget {
  const JobPickScreen({Key? key}) : super(key: key);

  @override
  _JobPickScreenState createState() => _JobPickScreenState();
}

class _JobPickScreenState extends State<JobPickScreen> {
  String selectedJob = '';
  TextEditingController customJobController = TextEditingController();

  void handleJobButton(String job) {
    setState(() {
      if (selectedJob == job) {
        selectedJob = '';
      } else if (job == '기타') {
        showCustomJobDialog();
      } else {
        selectedJob = job;
      }
    });
  }

  Widget buildJobButton(String job) {
    final isSelected = selectedJob == job;
    return SizedBox(
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: isSelected ? Colors.orange : Colors.black,
          side: BorderSide(
            color: isSelected ? Colors.orange : Colors.black12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          handleJobButton(job);
          print('Selected Job: $selectedJob');
        },
        child: Text(
          job,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void showCustomJobDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('기타 직업 입력'),
          content: TextField(
            controller: customJobController,
            decoration: const InputDecoration(
              hintText: '직업을 입력하세요',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                if (customJobController.text.isNotEmpty) {
                  setState(() {
                    selectedJob = customJobController.text;
                  });
                  print('Selected Job: $selectedJob');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ));
                } else {
                  // Show a warning if the input is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('경고'),
                        content: const Text('직업을 입력하세요.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void navigateToNextPage() {
    if (selectedJob.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ));
    } else {
      // Show a warning or perform any other action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('경고'),
            content: const Text('직업을 선택해주세요.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    customJobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.00, 0.80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black12,
                  fixedSize: const Size(361, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  print(selectedJob);
                  navigateToNextPage(); // Use the new function here
                },
                child: const Text('다음 단계',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.90, -0.90),
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
                  print(selectedJob);
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
            const Align(
              alignment: AlignmentDirectional(-0.80, -0.40),
              child: Text(
                '직업을 선택해주세요',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(-0.80, -0.30),
              child: Text(
                '딱 맞는 메시지 생성에 도움이 돼요!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, -0.10),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  buildJobButton('학생'),
                  buildJobButton('직장인'),
                  buildJobButton('파트 타이머'),
                  buildJobButton('취업준비생'),
                  buildJobButton('프리랜서'),
                  buildJobButton('무직'),
                  buildJobButton('기타'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
