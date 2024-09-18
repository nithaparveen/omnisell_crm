// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LeadStatusCard extends StatelessWidget {
  final int percentageComplete;
  final String leadStatus;
  final String currentStage;

  const LeadStatusCard({
    super.key,
    required this.percentageComplete,
    required this.leadStatus,
    required this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the percentage from an integer (e.g., 30) to a fraction (e.g., 0.3)
    double progressValue = percentageComplete / 100.0;
    var size = MediaQuery.sizeOf(context);

    return Card(
      color: Color(0xFF23224E),
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 6.0,
                  percent: progressValue,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$percentageComplete%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Complete",
                          style: GLTextStyles.cabinStyle(
                              size: 12,
                              weight: FontWeight.w400,
                              color: Colors.grey)),
                    ],
                  ),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lead Status",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(leadStatus,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: GLTextStyles.openSans(
                              size: 18,
                              weight: FontWeight.w600,
                              color: Colors.white)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF353967),
                          padding: EdgeInsets.only(left: 8, right: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Change Status',
                            style: GLTextStyles.cabinStyle(
                                size: 14,
                                weight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.width * .05),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(5),
                    value: progressValue,
                    color: Colors.blue,
                    backgroundColor: Colors.grey[300]!,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                stageLabel("New Enquiry", currentStage == "New Enquiry"),
                stageLabel("Invalid", currentStage == "Invalid"),
                stageLabel(
                    "Under Discussion", currentStage == "Under Discussion"),
                stageLabel("Completed", currentStage == "Completed"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget stageLabel(String stage, bool isActive) {
    return Column(
      children: [
        Icon(
          Icons.circle,
          size: 8,
          color: isActive ? Colors.blue : Colors.grey[400],
        ),
        SizedBox(height: 8),
        Text(stage,
            style: GLTextStyles.cabinStyle(
              size: isActive ? 14 : 12,
              weight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.white : Colors.grey[400],
            )),
      ],
    );
  }
}
