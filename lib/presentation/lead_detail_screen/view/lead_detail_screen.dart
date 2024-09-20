// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/assign_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/communication_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_detail_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_source_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_status_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/task_card.dart';
import 'package:provider/provider.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen({super.key, required this.leadId});
  final int leadId;

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<LeadDetailsController>(context, listen: false)
        .fetchData(widget.leadId, context);
    await Provider.of<LeadDetailsController>(context, listen: false)
        .fetchCommunicationSummary(widget.leadId, context);
    await Provider.of<LeadDetailsController>(context, listen: false)
        .fetchPhoneSummary(widget.leadId, context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text(
          "Lead Details",
          style: GLTextStyles.cabinStyle(size: 22),
        ),
        actions: [
          IconButton(
            onPressed: fetchData,
            tooltip: "Refresh",
            icon: const Icon(
              CupertinoIcons.refresh_circled,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Consumer<LeadDetailsController>(builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 46, 146, 157),
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailCard(
                title: controller.leadDetailModel.data?.name ?? 'N/A',
                addedDate: formatDate(
                    controller.leadDetailModel.data?.createdAt?.toString() ??
                        ''),
                lastActive: formatDate(
                    controller.leadDetailModel.data?.updatedAt?.toString() ??
                        ''),
                email: controller.leadDetailModel.data?.email ?? 'N/A',
                phone:
                    "${controller.leadDetailModel.data?.phoneNumber ?? 'N/A'}",
              ),
              LeadStatusCard(
                percentageComplete: controller
                        .leadDetailModel.data?.stage?.progressPercentage ??
                    0,
                leadStatus: controller
                            .leadDetailModel.data?.stage?.description !=
                        null
                    ? '${controller.leadDetailModel.data?.stage?.description}'
                    : "",
                currentStage: '${controller.leadDetailModel.data?.stage?.name}',
                leadId: "${controller.leadDetailModel.data?.id}",
              ),
              Row(
                children: [
                  Icon(
                    Icons.messenger_outline_rounded,
                    size: 18,
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text("Communication Status",
                      style: GLTextStyles.robotoStyle(
                          size: 18, weight: FontWeight.w400)),
                ],
              ),
              CommunicationCard(
                emailSend:
                    "${controller.communicationSummaryModel.data?.emailSendSummary.toString()}",
                emailReceiveSummary:
                    "${controller.communicationSummaryModel.data?.emailReceiveSummary.toString()}",
                phoneInbound:
                    "${controller.phoneSummaryModel.data?.callsInbound.toString()}",
                phoneOutbound:
                    "${controller.phoneSummaryModel.data?.callsOutbound.toString()}",
                leadId: "${controller.leadDetailModel.data?.id}",
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text("Upcoming Task & Follow-ups",
                      style: GLTextStyles.robotoStyle(
                          size: 18, weight: FontWeight.w400)),
                ],
              ),
              TaskCard(
                latestTask:
                    controller.leadDetailModel.data?.latestTask?.dueDate != null
                        ? formatDate1(controller
                            .leadDetailModel.data!.latestTask!.dueDate
                            .toString())
                        : "NA",
                latestFollowUp: controller.leadDetailModel.data?.latestFollowUp
                            ?.followUpDate !=
                        null
                    ? formatDate1(controller
                        .leadDetailModel.data!.latestFollowUp!.followUpDate
                        .toString())
                    : "NA",
                leadId: "${controller.leadDetailModel.data?.id}",
              ),
              Row(
                children: [
                  Icon(
                    Icons.share_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text("Lead Source",
                      style: GLTextStyles.robotoStyle(
                          size: 18, weight: FontWeight.w400)),
                ],
              ),
              LeadSourceCard(
                  leadSource: controller
                              .leadDetailModel.data?.leadSource?.name !=
                          null
                      ? "${controller.leadDetailModel.data?.leadSource?.name}"
                      : "NA"),
              Row(
                children: [
                  Icon(
                    Icons.person_add_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text("Assigned Salesperson",
                      style: GLTextStyles.robotoStyle(
                          size: 18, weight: FontWeight.w400)),
                ],
              ),
              AssignCard(
                  assignTo: controller.leadDetailModel.data?.assignedTo?.name !=
                          null
                      ? "${controller.leadDetailModel.data?.assignedTo?.name}"
                      : "NA")
            ],
          ),
        );
      }),
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      DateTime utcDateTime = DateTime.parse(dateString);
      DateTime localDateTime = utcDateTime.toLocal();
      return DateFormat('dd MMM yyyy hh:mm a').format(localDateTime);
    } catch (e) {
      return '';
    }
  }

  String formatDate1(String dateString) {
    if (dateString.isEmpty) return "";

    try {
      DateTime parsedDate = DateTime.parse(dateString);
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return dateString;
    }
  }
}
