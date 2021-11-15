import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

// ignore: must_be_immutable
class TodoCard extends StatefulWidget {
  TodoCard({
    Key? key,
    required this.uid,
    required this.id,
    this.title,
    this.icon,
    this.time,
    this.check,
    this.category,
    this.type,
  }) : super(key: key);

  String uid = '';
  String id = '';
  String? title;
  String? time;
  IconData? icon;
  String? category;
  bool? check;
  String? type;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 10),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Theme(
                  data:
                      ThemeData(unselectedWidgetColor: const Color(0xff5e616a)),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      activeColor: accentGreen,
                      checkColor: darkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: widget.check!,
                      onChanged: (value) {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection(widget.uid)
                              .doc(widget.id)
                              .update({'check': value});
                          widget.check = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onLongPress: () {
                      FirebaseFirestore.instance
                          .collection(widget.uid)
                          .doc(widget.id)
                          .delete();
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: 85,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: lightBlue,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                widget.icon,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title!,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: widget.type! == 'Important'
                                        ? const Color(0xffa30a0a)
                                        : const Color(0xff079428),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  widget.type! == 'Important'
                                      ? Icons.notification_important_rounded
                                      : Icons.schedule_rounded,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
