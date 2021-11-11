import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/services/auth_service.dart';
import '../colors.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desriptionController = TextEditingController();
  String category = '';
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: darkBlue),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'New Todo',
                      style: TextStyle(
                        letterSpacing: 3,
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    label('Task title'),
                    const SizedBox(height: 12),
                    titleTextField(context),
                    const SizedBox(height: 30),
                    label('Task type'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        typeChipData(
                          'Important',
                          const Color(0xffa30a0a),
                          Icons.notification_important_rounded,
                        ),
                        const SizedBox(width: 20),
                        typeChipData(
                          'Planned',
                          const Color(0xff079428),
                          Icons.schedule_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    label('Description'),
                    const SizedBox(height: 12),
                    descriptionTextField(context),
                    const SizedBox(height: 30),
                    label('Category'),
                    const SizedBox(height: 8),
                    Wrap(
                      children: [
                        categoryChipData('Food', icon: Icons.food_bank_rounded),
                        const SizedBox(width: 20),
                        categoryChipData('Workout', icon: Icons.sports),
                        const SizedBox(width: 20),
                        categoryChipData('Work', icon: Icons.work),
                        const SizedBox(width: 20),
                        categoryChipData('Home', icon: Icons.home_filled),
                        const SizedBox(width: 20),
                        categoryChipData('Study', icon: Icons.book_rounded),
                        const SizedBox(width: 20),
                        categoryChipData('Personal', icon: Icons.person),
                      ],
                    ),
                    const SizedBox(height: 30),
                    addTaskButton(context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell addTaskButton(BuildContext context) {
    return InkWell(
      onTap: () async{
        AuthClass _authClass = AuthClass();
        final uid = await _authClass.getUid();
        if (_titleController.text != '') {
          if (type != '' && category != '') {
            FirebaseFirestore.instance
                .collection('todo')
                .doc(uid)
                .collection('userTodos')
                .add({
              'title': _titleController.text,
              'type': type,
              'description': _desriptionController.text,
              'category': category
            });
            Navigator.of(context).pop();
          } else {
            const snackBar =
                SnackBar(content: Text('Please select type and category'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          const snackBar = SnackBar(content: Text('Please enter title'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: .5),
            borderRadius: BorderRadius.circular(15),
            color: fieldBlue),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_task_rounded,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text('Add Task',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Container descriptionTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 120,
      decoration: BoxDecoration(
        color: fieldBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _desriptionController,
        maxLines: null,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter the title',
          hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 15),
        ),
      ),
    );
  }

  Widget typeChipData(String label, Color? color, IconData? icon) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        avatar: Icon(
          icon,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: type == label ? color : fieldBlue,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget categoryChipData(String label, {Color? color, IconData? icon}) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        avatar: Icon(
          icon,
          color: category == label ? darkBlue : Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor:
            category == label ? const Color(0xff6cf8a9) : fieldBlue,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? darkBlue : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Container titleTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: fieldBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        validator: (str) {
          if (str!.isEmpty) {
            return 'Enter Something!';
          }
        },
        controller: _titleController,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter the title',
          hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 15),
        ),
      ),
    );
  }

  Text label(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 21,
        letterSpacing: 1,
      ),
    );
  }
}
