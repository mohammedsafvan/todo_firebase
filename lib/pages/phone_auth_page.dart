import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
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
              SizedBox(height: 150),
              textItem(context),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Enter the 5 digit OTP',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              otpField(context),
              SizedBox(height: 30),
              Visibility(
                visible: msgVisibility,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Send OTP again in ',
                        style: TextStyle(
                            color: Colors.yellowAccent[100], fontSize: 16),
                      ),
                      TextSpan(
                        text: '00:$start',
                        style: TextStyle(
                            color: Colors.purpleAccent[100], fontSize: 16),
                      ),
                      TextSpan(
                        text: ' sec',
                        style: TextStyle(
                            color: Colors.yellowAccent[100], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    'Let\'s Go',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
              child: Text(
                ' (+91) ',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            suffixIcon: wait
                ? Transform.scale(scale: .5, child: CircularProgressIndicator())
                : InkWell(
                    onTap: startTimer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 13),
                      child: Text(
                        sendText,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            border: InputBorder.none,
            hintText: 'Enter your Phone number',
            hintStyle: TextStyle(fontSize: 17, color: Colors.white70)),
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
      numberOfFields: 5,
      focusedBorderColor: Colors.grey,
      borderRadius: BorderRadius.circular(15),
      borderColor: Color(0xFF512DA8),
      textStyle: TextStyle(color: Colors.white),
      showFieldAsBox: true,
    );
  }
}
