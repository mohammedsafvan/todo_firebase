import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/pages.dart';
import '../colors.dart';
import '../widgets/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: _buildHomePageAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: "Important",
                check: false,
              ),
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: 'Planned',
                check: true,
              ),
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: "Important",
                check: false,
              ),
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: 'Planned',
                check: true,
              ),
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: 'Planned',
                check: false,
              ),
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: "Important",
                check: false,
              ),
              TodoCard(
                title: 'Let\'s water the plants',
                icon: Icons.yard_rounded,
                time: '11PM',
                type: "Important",
                check: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _builBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6cf8a9),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) => AddTodoPage()));
        },
        child: const Icon(
          Icons.add_rounded,
          size: 36,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomAppBar _builBottomAppBar() {
    return BottomAppBar(
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      color: lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size: 36,
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildHomePageAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        'Today\'s schedule',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.png'),
        ),
        SizedBox(
          width: 20,
        )
      ],
      bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: const [
                  Text(
                    'Wednesday 10',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(35)),
    );
  }
}



/// For future use
/// IconButton(
//   icon: const Icon(Icons.logout),
//   onPressed: () {
//     _authClass.logOut(context);
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (ctx) => const SignInPage()),
//         (route) => false);
//   },
// ),
