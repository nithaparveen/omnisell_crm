// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class LeadStatusCard extends StatelessWidget {
  final int percentageComplete;
  final String leadStatus;
  final String currentStage;
  final String leadId;

  const LeadStatusCard({
    super.key,
    required this.percentageComplete,
    required this.leadStatus,
    required this.currentStage,
    required this.leadId,
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
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => StatusChangeBottomSheet(
                              leadId: leadId,
                              currentStage: currentStage,
                            ),
                          );
                        },
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
                      backgroundColor: Colors.grey[300]!),
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

class StatusChangeBottomSheet extends StatefulWidget {
  final String leadId;
  final String currentStage;

  const StatusChangeBottomSheet({
    super.key,
    required this.leadId,
    required this.currentStage,
  });

  @override
  StatusChangeBottomSheetState createState() => StatusChangeBottomSheetState();
}

class StatusChangeBottomSheetState extends State<StatusChangeBottomSheet> {
  String? selectedStatus;
  final List<Map<String, dynamic>> statuses = [
    {"id": "7", "name": "Invalid"},
    {"id": "6", "name": "Under Discussion"},
    {"id": "3", "name": "Completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            padding: EdgeInsets.all(10),
            value: selectedStatus,
            hint: Text('Select Stage'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                selectedStatus = newValue;
              });
            },
            items: statuses.map((status) {
              return DropdownMenuItem<String>(
                value: status["name"],
                child: Text(status["name"]),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final selectedStageId = statuses.firstWhere(
                    (status) => status["name"] == selectedStatus,
                    orElse: () => {"id": null},
                  )["id"];

                  if (selectedStageId != null) {
                    Provider.of<LeadDetailsController>(context, listen: false)
                        .changeStage(widget.leadId, selectedStageId, context);
                  }

                  Navigator.of(context).pop();
                  setState(() {
                    Provider.of<LeadDetailsController>(context, listen: false)
                        .changeStage(widget.leadId, selectedStageId, context);
                  });
                  Provider.of<LeadDetailsController>(context, listen: false)
                      .fetchData(widget.leadId, context);
                  Provider.of<LeadDetailsController>(context, listen: false)
                      .fetchCommunicationSummary(widget.leadId, context);
                  Provider.of<LeadDetailsController>(context, listen: false)
                      .fetchPhoneSummary(widget.leadId, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF353967),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
