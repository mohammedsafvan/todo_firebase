import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xff070024)),
        child: SingleChildScrollView(
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
                        chipData('Important', color: 0xffa30a0a),
                        const SizedBox(width: 20),
                        chipData('Planned', color: 0xff5ac773),
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
                        chipData('Food', icon: Icons.food_bank_rounded),
                        const SizedBox(width: 20),
                        chipData('Workout', icon: Icons.sports),
                        const SizedBox(width: 20),
                        chipData('Work', icon: Icons.work),
                        const SizedBox(width: 20),
                        chipData('Home', icon: Icons.home_filled),
                        const SizedBox(width: 20),
                        chipData('Study', icon: Icons.book_rounded),
                        const SizedBox(width: 20),
                        chipData('Religion', icon: Icons.person),
                      ],
                    ),
                  ],
                ),
              )
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
        color: const Color(0xff150b40),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
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

  Widget chipData(String label, {int color = 0xff1f1452, IconData? icon}) {
    return Chip(
      avatar: icon != null
          ? Icon(
              icon,
              color: Colors.white,
            )
          : null,
      //     : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      backgroundColor: Color(color),
      labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Container titleTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff150b40),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
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
