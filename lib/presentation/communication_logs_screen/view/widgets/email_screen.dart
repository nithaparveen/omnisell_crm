import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/communication_logs_screen/controller/communication_controller.dart';
import 'package:provider/provider.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key, required this.leadId});
  final int leadId;

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommunicationController>(context, listen: false)
          .fetchEmailData(widget.leadId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email Summary")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CommunicationController>(
            builder: (context, controller, _) {
          if (controller.isEmailLoading) {
            return ShimmerEffect(size: MediaQuery.sizeOf(context));
          }

          if (controller.emailModel.data == null ||
              controller.emailModel.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: controller.emailModel.data!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: .5, color: Colors.black)),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.email),
                         SizedBox(width:MediaQuery.of(context).size.width *
                                    0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.9, 
                                child: Text(
                                  "${controller.emailModel.data?[index].subject}",
                                  style: GLTextStyles.cabinStyle(
                                    size: 16,
                                    weight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  // overflow: TextOverflow.ellipsis, // Handle overflow
                                  maxLines: 5, // Limit to 1 line
                                ),
                              ),
                              Text(
                                "${controller.emailModel.data?[index].to}",
                                maxLines: 3,
                                style: GLTextStyles.cabinStyle(
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          controller.emailModel.data?[index].updatedAt != null
                              ? DateFormat('dd MMM hh:mm a').format(
                                  DateTime.parse(controller
                                          .emailModel.data?[index].updatedAt ??
                                      ''))
                              : '',
                          style: GLTextStyles.cabinStyle(
                            size: 12,
                            weight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
              );
            },
          );
        }),
      ),
    );
  }
}
