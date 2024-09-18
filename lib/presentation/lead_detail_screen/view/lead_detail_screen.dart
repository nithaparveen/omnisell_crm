// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_status_card.dart';
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
              detailCard(
                  "${controller.leadDetailModel.data?.name}",
                  formatDate(
                      controller.leadDetailModel.data?.createdAt.toString()),
                  formatDate(
                      controller.leadDetailModel.data?.updatedAt.toString()),
                  "${controller.leadDetailModel.data?.email}",
                  "${controller.leadDetailModel.data?.phoneNumber}"),
              LeadStatusCard(
                percentageComplete: controller
                        .leadDetailModel.data?.stage?.progressPercentage ??
                    0,
                leadStatus:
                    '${controller.leadDetailModel.data?.stage?.description}',
                currentStage: '${controller.leadDetailModel.data?.stage?.name}',
              ),
              Text("Communication Status",
                  style: GLTextStyles.robotoStyle(
                      size: 18, weight: FontWeight.w400)),
              communicationCard(
                "${controller.communicationSummaryModel.data?.emailReceiveSummary.toString()}",
                "${controller.communicationSummaryModel.data?.emailSendSummary.toString()}",
                "${controller.phoneSummaryModel.data?.callsInbound.toString()}",
                "${controller.phoneSummaryModel.data?.callsOutbound.toString()}",
              ),
              Text("Upcoming Task & Follow-ups",
                  style: GLTextStyles.robotoStyle(
                      size: 18, weight: FontWeight.w400)),
              taskCard(
                  formatDate1(
                      "${controller.leadDetailModel.data?.latestTask?.dueDate}"),
                  formatDate1(
                      "${controller.leadDetailModel.data?.latestFollowUp?.followUpDate}")),
              Text("Lead Source",
                  style: GLTextStyles.robotoStyle(
                      size: 18, weight: FontWeight.w400)),
              leadSourceCard(
                  "${controller.leadDetailModel.data?.leadSource?.name}"),
              Text("Assigned Salesperson",
                  style: GLTextStyles.robotoStyle(
                      size: 18, weight: FontWeight.w400)),
              assignCard("${controller.leadDetailModel.data?.assignedTo?.name}")
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
    if (dateString.isEmpty) return ""; // Check for empty or null date

    try {
      DateTime parsedDate = DateTime.parse(dateString);
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return dateString; // In case of parsing error, return the original string
    }
  }

  Widget detailCard(String title, String addedDate, String lastActive,
      String email, String phone) {
    var size = MediaQuery.sizeOf(context);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 90, 90, 213),
                              Color.fromARGB(255, 185, 78, 151),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Text(title.toUpperCase(),
                      style: GLTextStyles.cabinStyle(
                          size: 18, weight: FontWeight.w600))
                ],
              ),
              SizedBox(height: size.width * .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email :",
                          style: GLTextStyles.openSans(
                              size: 12,
                              weight: FontWeight.w300,
                              color: Colors.grey)),
                      Row(
                        children: [
                          const Icon(
                            Icons.mail_outline_rounded,
                            size: 20,
                          ),
                          SizedBox(width: size.width * .02),
                          Text(email)
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile :",
                        style: GLTextStyles.openSans(
                            size: 12,
                            weight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.phone_enabled_outlined,
                            size: 18,
                          ),
                          SizedBox(width: size.width * .02),
                          Text(phone)
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: size.width * .04),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Added On",
                        style: GLTextStyles.openSans(
                            color: Colors.white,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .04),
                  Text(
                    addedDate,
                    style: GLTextStyles.openSans(
                        size: 15, weight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: size.width * .02),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 174, 221, 198),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Last Active",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 13,
                            weight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .04),
                  Text(
                    lastActive,
                    style: GLTextStyles.openSans(
                        size: 15, weight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget communicationCard(String emailSend, String emailReceiveSummary,
      String phoneInbound, String phoneOutbound) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Emails",
                  style: GLTextStyles.cabinStyle(
                      size: 18, weight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: emailReceiveSummary,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(text: "  "),
                        TextSpan(
                          text: 'Received',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: emailSend,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(text: "  "),
                        TextSpan(
                          text: 'Send',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Send Mail",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
              Text("Calls",
                  style: GLTextStyles.cabinStyle(
                      size: 18, weight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: phoneInbound,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(text: "  "),
                        TextSpan(
                          text: 'Inbound',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: phoneOutbound,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(text: "  "),
                        TextSpan(
                          text: 'Outbound',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Add Call Log",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget taskCard(String latestTask, String latestFollowUp) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Task",
                  style: GLTextStyles.cabinStyle(
                      size: 16, weight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(latestTask),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Add Task",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
              Text("Follow-up",
                  style: GLTextStyles.cabinStyle(
                      size: 16, weight: FontWeight.w500)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(latestFollowUp),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Add Follow-up",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leadSourceCard(String leadsource) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(padding: EdgeInsets.all(16.0), child: Text(leadsource)),
      ),
    );
  }

  Widget assignCard(String assignTo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(padding: EdgeInsets.all(16.0), child: Text(assignTo)),
      ),
    );
  }
}
