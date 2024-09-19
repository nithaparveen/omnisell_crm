import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';

class TaskCard extends StatelessWidget {
  final String latestTask;
  final String latestFollowUp;

  const TaskCard({
    Key? key,
    required this.latestTask,
    required this.latestFollowUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Task",
                  style: GLTextStyles.cabinStyle(
                      size: 14, weight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(latestTask),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Add Task",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
              Text("Follow-up",
                  style: GLTextStyles.cabinStyle(
                      size: 14, weight: FontWeight.w400)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(latestFollowUp),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Add Follow-up",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
