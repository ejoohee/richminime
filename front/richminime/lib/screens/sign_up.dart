import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:richminime/screens/sign_up2.dart';

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
          const SizedBox(height: 50),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: MediaQuery.of(context).size.width,
            animation: true,
            animationDuration: 1200,
            lineHeight: 30,
            percent: 0.25,
            center: const Text('1/4'),
            barRadius: const Radius.circular(16),
            progressColor: Theme.of(context).cardColor,
          ),
          const SizedBox(
            height: 50,
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomCenter,
              child: Text(
                "서비스 이용을 위해\n카드사의 정보가 필요해요",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: DropdownButton(
              dropdownColor: Colors.grey.shade200,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Dunggeunmo',
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.all(10),
              value: _selectBank,
              items: _bankList.map((bank) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
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
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 135,
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '다음단계',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Icon(Icons.arrow_forward_rounded,
                            color: Colors.white),
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
