import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../widgets/widgets.dart';
import '../services/auth_service.dart';
import 'pages.dart';

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
          color: darkBlue,
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
              customButton(
                  'assets/google.svg', 'Continue with Google', 25, context, () {
                _authClass.googleSignIn(context);
              }),
              const SizedBox(height: 15),
              customButton(
                  'assets/phone.svg', 'Continue with Phone', 30, context, () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const PhoneAuthPage()));
              }),
              const SizedBox(height: 15),
              const Text('Or',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              const SizedBox(height: 15),
              textField('Email', _emailController, context),
              const SizedBox(height: 15),
              textField('Password', _passwordController, context,
                  obscureText: true),
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
