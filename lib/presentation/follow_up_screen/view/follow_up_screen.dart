import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/follow_up_screen/controller/follow_up_controller.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';

class FollowUpScreen extends StatefulWidget {
  final String leadId;

  const FollowUpScreen({super.key, required this.leadId});

  @override
  State<FollowUpScreen> createState() => _FollowUpScreenState();
}

class _FollowUpScreenState extends State<FollowUpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FollowUpController>(context, listen: false)
          .fetchData(widget.leadId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowUpController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.followUpModel.data == null ||
            controller.followUpModel.data!.isEmpty) {          return const Center(child: Text("No Follow-Up & Notes available"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FixedTimeline(
                  theme: TimelineThemeData(
                    nodePosition: 0.25,
                    connectorTheme: const ConnectorThemeData(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                 
                  children: controller.followUpModel.data!
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final event = entry.value;

                    return TimelineTile(
                      oppositeContents: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: event.createdAt != null
                            ? Text(
                                DateFormat('dd MMM yyyy hh:mm a')
                                    .format(event.createdAt!),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      contents: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Card(
                          elevation: 1,
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                labelValueRow(
                                  "Assign To:  ",
                                  "${controller.followUpModel.data?[index].assignedToUser?.name}",
                                ),
                                labelValueRow(
                                  "Due:  ",
                                  controller.followUpModel.data?[index]
                                              .followUpDate !=
                                          null
                                      ? DateFormat('dd MMM yyyy hh:mm a')
                                          .format(event.followUpDate!)
                                      : "N/A",
                                ),
                                labelValueRow(
                                    "Created By:  ", event.createdBy?.name ?? ""),
                                labelValueRow("Status:  ", event.status ?? ""),
                                labelValueRow(
                                  "Note:  ",
                                  event.note ?? "",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      node: const TimelineNode(
                        indicator: DotIndicator(
                          color: Colors.blue,
                          size: 10.0,
                        ),
                        startConnector: SolidLineConnector(),
                        endConnector: SolidLineConnector(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget labelValueRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GLTextStyles.openSans(
                  size: 14, weight: FontWeight.w700, color: Colors.grey)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: GLTextStyles.openSans(
                    size: 15, weight: FontWeight.w500, color: Colors.black),
                maxLines: 5,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}