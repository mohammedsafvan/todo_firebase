import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/home_page.dart';
import 'package:todo_firebase/pages/signup_page.dart';
import 'package:todo_firebase/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SignUpPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  /// Checking whether the user logged in or not with the [uid]
  /// and setting the first page(screen) according to the result
  isLoggedIn() async {
    String? uid = await authClass.getUid();
    if (uid != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: currentPage,
    );
  }
}
