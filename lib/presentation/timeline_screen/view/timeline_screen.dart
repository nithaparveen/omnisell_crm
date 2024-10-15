import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/presentation/timeline_screen/controller/timeline_controller.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TimeLineScreen extends StatefulWidget {
  final String leadId; // Pass the leadId to fetch data

  const TimeLineScreen({super.key, required this.leadId});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TImeLineController>(context, listen: false)
          .fetchData(widget.leadId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TImeLineController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.timeLineModel.data == null ||
            controller.timeLineModel.data!.isEmpty) {
          return const Center(child: Text("No timeline events available"));
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
                  children: controller.timeLineModel.data!.map((event) {
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
                              : const SizedBox()),
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
                            child: 
                            Text(
                              event.description.toString(),
                              style: const TextStyle(fontSize: 14),
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
}
