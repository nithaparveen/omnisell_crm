import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/communication_logs_screen/controller/communication_controller.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key, required this.leadId});
  final int leadId;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommunicationController>(context, listen: false)
          .fetchCallData(widget.leadId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call Summary")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CommunicationController>(
            builder: (context, controller, _) {
          if (controller.isCallLoading) {
            return ShimmerEffect(size: MediaQuery.sizeOf(context));
          }

          if (controller.callModel.data == null ||
              controller.callModel.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: .5, color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${controller.callModel.data?[index].callSummary}",
                          style: GLTextStyles.cabinStyle(
                              size: 16,
                              weight: FontWeight.w600,
                              color: Colors.black)),
                      Text(
                        controller.callModel.data?[index].dateTimeOfCall != null
                            ? DateFormat('dd-MM-yyy hh:mm a').format(
                                DateTime.parse(controller
                                        .callModel.data?[index].dateTimeOfCall
                                        ?.toString() ??
                                    ''))
                            : '',
                        style: GLTextStyles.cabinStyle(
                          size: 12,
                          weight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
