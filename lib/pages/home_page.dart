import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_firebase/pages/pages.dart';
import 'package:todo_firebase/services/auth_service.dart';
import '../colors.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthClass _authClass = AuthClass();
  String uid = '';
  late final Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    _stream = FirebaseFirestore.instance
        .collection(uid)
        .orderBy(
          'check',
        )
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: _buildHomePageAppBar(),
      body: _buildTodos(),
      // bottomNavigationBar: _builBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentGreen,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const AddTodoPage()));
        },
        child: const Icon(
          Icons.add_rounded,
          size: 36,
          color: Colors.black,
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _buildTodos() {
    return StreamBuilder(
        stream: _stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: accentGreen,
                ),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_7zotccpl.json'),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  IconData icon;
                  Map<String, dynamic> document =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  switch (document['category']) {
                    case 'Work':
                      icon = Icons.work_rounded;
                      break;
                    case 'Food':
                      icon = Icons.food_bank_rounded;
                      break;
                    case 'Workout':
                      icon = Icons.sports_rounded;
                      break;
                    case 'Home':
                      icon = Icons.home_rounded;
                      break;
                    case 'Study':
                      icon = Icons.book_rounded;
                      break;
                    case 'Personal':
                      icon = Icons.person_rounded;
                      break;
                    default:
                      icon = Icons.access_alarm_rounded;
                  }
                  return TodoCard(
                    uid: uid,
                    id: snapshot.data!.docs[index].id,
                    title: document['title'],
                    type: document['type'],
                    icon: icon,
                    // time: '22pm',
                    time: '',
                    check: document['check'] ?? false,
                  );
                });
          }
        });
  }

  AppBar _buildHomePageAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        '${DateFormat('EEEE').format(DateTime.now())} ${DateTime.now().day}',
        style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            _authClass.logOut(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const SignInPage()),
                (route) => false);
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage(
              'assets/avatar.png',
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
