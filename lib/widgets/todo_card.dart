import 'package:flutter/material.dart';
import 'package:todo_firebase/colors.dart';

class TodoCard extends StatefulWidget {
  TodoCard({
    Key? key,
    this.title,
    this.icon,
    this.time,
    this.check,
    this.type,
  }) : super(key: key);

  String? title;
  String? time;
  IconData? icon;
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
                  //TODO May need to change
                  data:
                      ThemeData(unselectedWidgetColor: const Color(0xff5e616a)),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      activeColor: const Color(0xff6cf8a9),
                      checkColor: darkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: widget.check!,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 85,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: lightBlue,
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          Icon(
                            widget.icon,
                            size: 35,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: widget.type! == 'Important'
                                              ? const Color(0xffa30a0a)
                                              : const Color(0xff079428),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Icon(
                                        widget.type! == 'Important'
                                            ? Icons
                                                .notification_important_rounded
                                            : Icons.schedule_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: fieldBlue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Icon(
                                        Icons.notification_important_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.time!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
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
