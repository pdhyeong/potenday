import 'package:flutter/material.dart';

class ExportTextScreen extends StatelessWidget {
  const ExportTextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController(
        text:
            '[홍길동/223055] 성적 관련 정정 요청\n안녕하세요. 교수님.\n홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다.  홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다.  홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다.  홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다. 홍길동입니다.  ');

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
            const Align(
              alignment: AlignmentDirectional(-0.60, -0.40),
              child: Text(
                '메시지가 완성되었어요.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 0.1),
              child: SizedBox(
                width: 361,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 9, // Set the maximum number of visible lines
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:
                                Colors.black12, // Set your desired border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize:
                            16, // Set the font size according to your preference
                      ),
                      autofocus: true,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, 0.5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 210, 48),
                  fixedSize: const Size(361, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Access the entered text using textEditingController.text
                  print('Entered Text: ${textEditingController.text}');
                },
                child: const Text(
                  '메시지 보내기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
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
