import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:todo_firebase/services/auth_service.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  bool msgVisibility = false;
  String sendText = 'Send';
  String verificationIdFinal = '';
  String smsCode = '';
  TextEditingController phoneNumberController = TextEditingController();
  final AuthClass _authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff070024),
      appBar: AppBar(
        elevation: 0,
        
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              textField(context),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const Text(
                      'Enter the 5 digit OTP',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              otpField(context),
              const SizedBox(height: 30),
              Visibility(
                visible: msgVisibility,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Send OTP again in ',
                        style: TextStyle(
                            color: Colors.blueGrey[300], fontSize: 16),
                      ),
                      TextSpan(
                        text: '00:$start',
                        style: TextStyle(
                            color: Colors.blueGrey[100], fontSize: 16),
                      ),
                      TextSpan(
                        text: ' sec',
                        style: TextStyle(
                            color: Colors.blueGrey[300], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _authClass.signInWithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      'Let\'s Go',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff150b40),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.white, fontSize: 21),
        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
              child: Text(
                ' (+91) ',
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
            ),
            suffixIcon: wait
                ? Transform.scale(
                    scale: .5, child: const CircularProgressIndicator())
                : InkWell(
                    onTap: () async {
                      await _authClass.verifyPhoneNumber(
                          '+91 ${phoneNumberController.text}',
                          context,
                          setData);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 13),
                      child: Text(
                        sendText,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            border: InputBorder.none,
            hintText: 'Enter your Phone number',
            hintStyle: const TextStyle(fontSize: 17, color: Colors.white70)),
      ),
    );
  }

  void startTimer() {
    setState(() {
      wait = true;
      msgVisibility = true;
    });
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (timer) {
      if (start <= 0) {
        setState(() {
          timer.cancel();
          wait = false;
          msgVisibility = false;
          sendText = 'Resend';
          start = 30;
        });
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  Widget otpField(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      focusedBorderColor: Colors.grey,
      borderRadius: BorderRadius.circular(15),
      borderColor: const Color(0xFF512DA8),
      textStyle: const TextStyle(color: Colors.white),
      showFieldAsBox: true,
      onSubmit: (String pin) {
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
