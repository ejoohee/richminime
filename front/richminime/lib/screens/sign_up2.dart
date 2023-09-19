import 'package:flutter/material.dart';
import 'package:richminime/screens/sign_up3.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp2 extends StatefulWidget {
  final String bank;

  const SignUp2({required this.bank, Key? key}) : super(key: key);

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  late String bankCode;

  @override
  void initState() {
    super.initState();
    switch (widget.bank) {
      case 'KB':
        bankCode = '0301';
        break;
      case '현대':
        bankCode = '0302';
        break;
      case '삼성':
        bankCode = '0303';
        break;
      case 'NH':
        bankCode = '0304';
        break;
      case '비씨':
        bankCode = '0305';
        break;
      case '신한':
        bankCode = '0306';
        break;
      case '씨티':
        bankCode = '0307';
        break;
      case '우리':
        bankCode = '0309';
        break;
      case '롯데':
        bankCode = '0311';
        break;
      case '하나':
        bankCode = '0313';
        break;
    }
  }

  onNoButtonTap() async {
    final Uri url;
    switch (bankCode) {
      case '0301':
        url = Uri.parse("https://m.kbcard.com/CMN/DVIEW/MOCMCXHIAMBC0008");
        break;
      case '0302':
        url = Uri.parse("https://www.hyundaicard.com/cpm/mb/CPMMB0201_01.hc");
        break;
      case '0303':
        url = Uri.parse(
            "https://www.samsungcard.com/personal/registration/UHPPMM0110M0.jsp?click=gnb_top_joinmember");
        break;
      case '0304':
        url = Uri.parse(
            "https://www.nhmembers.co.kr/nhmem/join/joinIntro.nh?PRL_CHAN_C=566");
        break;
      case '0305':
        url = Uri.parse(
            "https://m.bccard.com/app/mobileweb/CustReg.do?exec=custAgreeReq");
        break;
      case '0306':
        url = Uri.parse(
            "https://www.shinhancard.com/mob/MOBFM003N/MOBFM003C06.shc");
        break;
      case '0307':
        url = Uri.parse(
            "https://www.citibank.co.kr/temp/CusSecnCnts0100.act?P_name=DelfinoG3");
        break;
      case '0309':
        url = Uri.parse(
            "https://pc.wooricard.com/dcpc/yh1/mmb/mmb02/H1MMB102S00.do");
        break;
      case '0311':
        url = Uri.parse("https://www.lottecard.co.kr/app/LPMBRAA_V200.lc");
        break;
      case '0313':
        url = Uri.parse("https://smart.hanacard.co.kr/MPAREG100M.web");
        break;
      default:
        url = Uri.parse("https://naver.com");
        break;
    }

    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(50),
              alignment: Alignment.bottomCenter,
              child: Text(
                "카드사 홈페이지 아이디를 보유하고 계신가요?",
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
            child: SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp3(
                            code: bankCode,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBEBE),
                      ),
                      child: const Text(
                        '예',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onNoButtonTap,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBEBE),
                      ),
                      child: const Text(
                        '아니오',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
