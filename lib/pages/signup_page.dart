import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_firebase/services/auth_service.dart';
import 'home_page.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final AuthClass _authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              customButton('assets/google.svg', 'Continue with Google', 25, () {
                _authClass.googleSignIn(context);
              }),
              const SizedBox(height: 15),
              customButton(
                  'assets/phone.svg', 'Continue with Phone', 30, () {}),
              const SizedBox(height: 15),
              const Text('Or',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              const SizedBox(height: 15),
              textItem('Email', _emailController),
              const SizedBox(height: 15),
              textItem('Password', _passwordController, obscureText: true),
              const SizedBox(height: 30),
              signUpbutton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (builder) => const SignInPage()),
                          (route) => false);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color(0xfffd746c), fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(
      String imgPath, String buttonText, double size, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 1, color: Colors.grey),
          ),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgPath,
                height: size,
                width: size,
              ),
              const SizedBox(width: 15),
              Text(buttonText, style: const TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        keyboardType: labelText == 'Email' ? TextInputType.emailAddress : null,
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget signUpbutton() {
    return InkWell(
      onTap: () async {
        try {
          setState(() {
            isLoading = true;
          });
          UserCredential user = await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

          setState(() {
            isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              //TODO: Need to pass the user
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c),
            ],
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Sign Up',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}