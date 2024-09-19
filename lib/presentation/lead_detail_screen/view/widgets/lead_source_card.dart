import 'package:flutter/material.dart';

class LeadSourceCard extends StatelessWidget {
  final String leadSource;

  const LeadSourceCard({
    Key? key,
    required this.leadSource,
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
            leadSource,
            style: TextStyle(
              fontSize: 16, // Adjust size as needed
              fontWeight: FontWeight.w500, // Adjust weight as needed
            ),
          ),
        ),
      ),
    );
  }
}
