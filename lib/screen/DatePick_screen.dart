//DatePick_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:potenday/screen/JobPick_screen.dart';

class BirthDatePicker extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final String initDateStr;

  const BirthDatePicker({
    super.key,
    required this.onDateTimeChanged,
    required this.initDateStr,
  });

  @override
  Widget build(BuildContext context) {
    final initDate =
        DateFormat('yyyy-MM-dd').parse(initDateStr ?? '2000-01-01');
    return SizedBox(
      height: 150,
      width: 300,
      child: CupertinoDatePicker(
        minimumYear: 1900,
        maximumYear: DateTime.now().year,
        initialDateTime: initDate,
        maximumDate: DateTime.now(),
        onDateTimeChanged: onDateTimeChanged,
        mode: CupertinoDatePickerMode.date,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime selectedDate = DateTime.now(); // Initial date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.00, 0.00),
              child: BirthDatePicker(
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                },
                initDateStr: '2000-01-01',
              ),
            ),
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
                  print(selectedDate.toString().substring(0, 15));
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const JobPickScreen(),
                  ));
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
                  backgroundColor: Colors.white, // Set text color to black
                  side: const BorderSide(color: Colors.black26),
                  fixedSize: const Size(95, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  print('Button pressed ...');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const JobPickScreen(),
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
                '생년월일을 알려주세요',
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
          ],
        ),
      ),
    );
  }
}
