import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:richminime/screens/login.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:richminime/services/user_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUp4 extends StatefulWidget {
  final String organization;
  final String uuid;
  const SignUp4({required this.organization, required this.uuid, Key? key})
      : super(key: key);
  @override
  State<SignUp4> createState() => _SignUp4State();
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('-', '');
    if (newText.length > 4) {
      newText =
          '${newText.substring(0, 4)}-${newText.substring(4, newText.length)}';
    }
    if (newText.length > 9) {
      newText =
          '${newText.substring(0, 9)}-${newText.substring(9, newText.length)}';
    }
    if (newText.length > 14) {
      newText =
          '${newText.substring(0, 14)}-${newText.substring(14, newText.length)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class _SignUp4State extends State<SignUp4> with SingleTickerProviderStateMixin {
  final maskFormatter = MaskTextInputFormatter(
    mask: '****-****-****-****',
    //입력된 숫자를 *로 표시하는 마스크

    filter: {"*": RegExp('[0-9]')},
    type: MaskAutoCompletionType.eager,
  ); //

  bool isLoading = false;
  bool isEmailVerified = false;
  final _formKey = GlobalKey<FormState>(); // Form 위젯에 키를 할당하여 유효성 검사에 사용
  late AnimationController _controller;
  late Animation<double> _animation;
  double percent = 0.75;
  @override
  void initState() {
    super.initState();
    _setupTextControllerListeners();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // 애니메이션의 지속시간
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.75, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          percent = _animation.value;
        });
      });
    _controller.forward();
  }

  // 이메일 유효성 검사를 위한 정규식
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController cardEmailController = TextEditingController();
  TextEditingController cardPasswordController = TextEditingController();
  TextEditingController cardNickNameController = TextEditingController();
  TextEditingController verificationController = TextEditingController();
  TextEditingController cardPasswordConfirmController = TextEditingController();
  TextEditingController cardNumController = TextEditingController();
  TextEditingController cardNumController1 = TextEditingController();
  TextEditingController cardNumController2 = TextEditingController();
  TextEditingController cardNumController3 = TextEditingController();
  TextEditingController cardNumController4 = TextEditingController();
  final userService = UserService();
  String enteredCode = "";
  void _setupTextControllerListeners() {
    cardNumController1.addListener(() {
      if (cardNumController1.text.length == 4) {
        FocusScope.of(context).nextFocus(); // 다음 포커스로 이동
      }
    });

    cardNumController2.addListener(() {
      if (cardNumController2.text.length == 4) {
        FocusScope.of(context).nextFocus(); // 다음 포커스로 이동
      }
    });

    cardNumController3.addListener(() {
      if (cardNumController3.text.length == 4) {
        FocusScope.of(context).nextFocus(); // 다음 포커스로 이동
      }
    });

    cardNumController4.addListener(() {
      if (cardNumController4.text.length == 4) {
        FocusScope.of(context).nextFocus();
      }
    });
  }

  onCheckCodeTap() async {
    enteredCode = verificationController.text;
    final email = cardEmailController.text;
    final response = await userService.checkCode(email, enteredCode);

    if (response == "true") {
      setState(() {
        isEmailVerified = true; // 인증 성공 시 변수를 true로 설정
      });
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } else {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const Text('인증 번호를 다시 확인해주세요.'),
            actions: <Widget>[
              TextButton(
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

  showVerificationDialog() async {
    String email = cardEmailController.text;
    setState(() {
      isLoading = true; // 로딩 시작
    });
    final response = await userService.sendCheckEmailCode(email);
    setState(() {
      isLoading = false; // 로딩 완료
    });
    if (response == "true") {
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('이메일 인증'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('이메일로 발송된 인증번호를 입력하세요.'),
                TextFormField(
                  controller: verificationController,
                  decoration: const InputDecoration(
                    labelText: '인증번호',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onCheckCodeTap,
                child: const Text('확인'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // 대화상자 닫기
                },
                child: const Text('취소'),
              ),
            ],
          );
        },
      );
    } else {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const Text('다시 시도해주세요.'),
            actions: <Widget>[
              TextButton(
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

  onVarificationButtonTap() async {
    String email = cardEmailController.text;
    if (emailRegex.hasMatch(email)) {
      final check = await userService.checkEmail(email);
      if (check == "true") {
        await showVerificationDialog();
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('알림'),
              content: const Text('이미 가입된 이메일입니다.'),
              actions: <Widget>[
                TextButton(
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const Text('유효한 이메일을 입력하세요.'),
            actions: <Widget>[
              TextButton(
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

  onSignUpButtonTap() async {
    String email = cardEmailController.text;
    String password = cardPasswordController.text;
    String nickname = cardNickNameController.text;
    String organization = widget.organization;
    String cardNumber = cardNumController1.text +
        cardNumController2.text +
        cardNumController3.text +
        cardNumController4.text;
    String uuid = widget.uuid;
    if (!isEmailVerified) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const Text('이메일 인증이 필요합니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
      return; // 이메일이 인증되지 않았으면 더 이상 진행하지 않음
    }
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // 로딩 시작
      });
      final response = await userService.signUp(
          email, password, nickname, organization, cardNumber, uuid);
      if (response == "true") {
        setState(() {
          isLoading = false; // 로딩 시작
        });
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('알림'),
              content: const Text('카드번호를 확인해주세요.'),
              actions: <Widget>[
                TextButton(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 50),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: MediaQuery.of(context).size.width,
                  animation: false,
                  animationDuration: 1200,
                  lineHeight: 30,
                  percent: percent,
                  center: const Text('4/4'),
                  barRadius: const Radius.circular(16),
                  progressColor: Colors.red[200],
                ),
                const SizedBox(height: 100),
                Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: cardEmailController,
                                    readOnly: isEmailVerified,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '이메일을 입력하세요.';
                                      } else if (!emailRegex.hasMatch(value)) {
                                        return '유효한 이메일을 입력하세요.';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: isEmailVerified
                                          ? Colors.green
                                          : null, // 여기에서 조건에 따라 색상을 설정
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      labelText: '이메일',
                                      fillColor: Color(0xFFFFFDFD),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: onVarificationButtonTap,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFBEBE),
                                      ),
                                      child: const Text(
                                        "인증",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: cardPasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 입력해주세요.';
                              } else if (value.length < 8 ||
                                  value.length > 16) {
                                return '비밀번호는 8~16자리 사이여야 합니다.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: '비밀번호',
                              fillColor: Color(0xFFFFFDFD),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: cardPasswordConfirmController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 입력해주세요.';
                              } else if (value != cardPasswordController.text) {
                                return '비밀번호가 일치하지 않습니다.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: '비밀번호 확인',
                              fillColor: Color(0xFFFFFDFD),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    height: 60,
                                    width: 80,
                                    alignment: Alignment.centerLeft,
                                    color: Colors.white,
                                    child: const Text('카드번호',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: cardNumController1,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        bottom: 20,
                                      ),
                                      counterText: "",
                                      fillColor: Colors.grey[50],
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: cardNumController2,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        bottom: 20,
                                      ),
                                      counterText: "",
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: cardNumController3,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        bottom: 20,
                                      ),
                                      counterText: "",
                                      fillColor: Colors.grey[50],
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: cardNumController4,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        bottom: 20,
                                      ),
                                      counterText: "",
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: cardNickNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '닉네임을 입력해주세요.';
                              } else if (value.length < 2 || value.length > 8) {
                                return '닉네임은 2~8자리 사이여야 합니다.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: '닉네임',
                              fillColor: Color(0xFFFFFDFD),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: onSignUpButtonTap,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 110,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFBEBE),
                                  ),
                                  child: const Text(
                                    "다음",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.pink[100],
                        backgroundColor: Colors.black.withOpacity(0.5),
                        strokeWidth: 5.0,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '1분 정도 소요될 수 있습니다.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
