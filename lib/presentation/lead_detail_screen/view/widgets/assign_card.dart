import 'package:flutter/material.dart';

class AssignCard extends StatelessWidget {
  final String assignTo;

  const AssignCard({
    Key? key,
    required this.assignTo,
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
          child: Text(
            assignTo,
            style: const TextStyle(
              fontSize: 16, // Adjust size as needed
              fontWeight: FontWeight.w500, // Adjust weight as needed
            ),
          ),
        ),
      ),
    );
  }
}
