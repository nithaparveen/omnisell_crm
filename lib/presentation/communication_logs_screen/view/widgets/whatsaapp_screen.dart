import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/communication_logs_screen/controller/communication_controller.dart';
import 'package:provider/provider.dart';

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({super.key, required this.leadId});
  final String leadId;

  @override
  State<WhatsAppScreen> createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommunicationController>(context, listen: false)
          .fetchWhatsAppData(widget.leadId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WhatsApp Summary")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CommunicationController>(
            builder: (context, controller, _) {
          if (controller.isWhatsAppLoading) {
            return ShimmerEffect(size: MediaQuery.sizeOf(context));
          }

          if (controller.whatsappModel.data == null ||
              controller.whatsappModel.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: controller.whatsappModel.data!.length,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text("${controller.whatsappModel.data?[index].body}",
                        maxLines: 4,
                            style: GLTextStyles.cabinStyle(
                                size: 15,
                                weight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                      Text(
                        controller.whatsappModel.data?[index].messageDate != null
                            ? DateFormat('dd MMM hh:mm a').format(
                                DateTime.parse(controller
                                        .whatsappModel.data?[index].messageDate
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
