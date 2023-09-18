import 'package:flutter/material.dart';
import 'package:richminime/screens/signup2.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _bankList = [
    'KB',
    '현대',
    '삼성',
    'NH',
    '비씨',
    '신한',
    '씨티',
    '우리',
    '롯데',
    '하나',
  ];

  var _selectBank = '삼성';
  bool isSelectBank = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(50),
              alignment: Alignment.bottomCenter,
              child: Text(
                "서비스 이용을 위해 카드사의 아이디가 필요해요",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: DropdownButton(
              value: _selectBank,
              items: _bankList.map((bank) {
                return DropdownMenuItem(
                  value: bank,
                  child: Text('$bank카드'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectBank = value!;
                  isSelectBank = true;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isSelectBank
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUp2(
                                  bank: _selectBank,
                                )));
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFBEBE),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '다음단계',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
