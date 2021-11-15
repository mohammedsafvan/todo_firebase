import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../services/auth_service.dart';
import 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthClass _authClass = AuthClass();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff070024),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
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
              const Text(
                'Or',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 15),
              textField('Email', _emailController, context),
              const SizedBox(height: 15),
              textField('Password', _passwordController, context,
                  obscureText: true),
              const SizedBox(height: 30),
              signInbutton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (builder) => const SignInPage(),
                          ),
                          (route) => false);
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Color(0xfffd746c), fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signInbutton() {
    return InkWell(
      onTap: () async {
        try {
          setState(() {
            isLoading = true;
          });
          UserCredential user = await _auth.signInWithEmailAndPassword(
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
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff070024)),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Sign In',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}
