import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

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
      height: 200,
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
                onPressed: () {
                  print(selectedDate.toString().substring(0, 10));
                },
                child: const Text('다음 단계'),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.90, -0.90),
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed ...');
                },
                child: const Text('건너뛰기'),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(-0.80, -0.40),
              child: Text(
                '생년월일을 알려주세요',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(-0.80, -0.30),
              child: Text(
                '딱 맞는 메시지 생성에 도움이 되요!',
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
