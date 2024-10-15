import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/communication_logs_screen/view/communication_logs_screen.dart';
import 'package:omnisell_crm/presentation/follow_up_screen/view/follow_up_screen.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/assign_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/communication_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_detail_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_source_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/lead_status_card.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/widgets/task_card.dart';
import 'package:omnisell_crm/presentation/payments_screen/view/payments_screen.dart';
import 'package:omnisell_crm/presentation/task_screen/view/task_screen.dart';
import 'package:omnisell_crm/presentation/timeline_screen/view/timeline_screen.dart';
import 'package:provider/provider.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen({super.key, required this.leadId});
  final String leadId;

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
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
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.blueAccent,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Details'),
            Tab(text: 'Timeline'),
            Tab(text: 'Follow-Up & Notes'),
            Tab(text: 'Communication Logs'),
            Tab(text: 'Payments'),
            Tab(text: 'Task'),
          ],
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildDetailsTab(size),
          TimeLineScreen(leadId: widget.leadId),
          FollowUpScreen(leadId: widget.leadId),
          const CommunicationLogsScreen(),
          const PaymentScreen(),
          const TaskScreen(),
        ],
      ),
    );
  }

  Widget buildDetailsTab(Size size) {
    return Consumer<LeadDetailsController>(builder: (context, controller, _) {
      if (controller.isLoading) {
        return ShimmerEffect(size: size);
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailCard(
              title: controller.leadDetailModel.data?.name ?? 'N/A',
              addedDate: formatDate(
                  controller.leadDetailModel.data?.createdAt?.toString() ?? ''),
              lastActive: formatDate(
                  controller.leadDetailModel.data?.updatedAt?.toString() ?? ''),
              email: controller.leadDetailModel.data?.email ?? 'N/A',
              phone: "${controller.leadDetailModel.data?.phoneNumber ?? 'N/A'}",
            ),
            LeadStatusCard(
              percentageComplete:
                  controller.leadDetailModel.data?.stage?.progressPercentage ??
                      0,
              leadStatus:
                  controller.leadDetailModel.data?.stage?.description ?? "",
              currentStage: '${controller.leadDetailModel.data?.stage?.name}',
              leadId: "${controller.leadDetailModel.data?.id}",
            ),
            buildSectionTitle(Icons.messenger_outline_rounded,
                "Communication Status", size),
            CommunicationCard(
              emailSend:
                  "${controller.communicationSummaryModel.data?.emailSendSummary}",
              emailReceiveSummary:
                  "${controller.communicationSummaryModel.data?.emailReceiveSummary}",
              phoneInbound:
                  "${controller.phoneSummaryModel.data?.callsInbound}",
              phoneOutbound:
                  "${controller.phoneSummaryModel.data?.callsOutbound}",
              leadId: "${controller.leadDetailModel.data?.id}",
            ),
            buildSectionTitle(Icons.calendar_today_outlined,
                "Upcoming Task & Follow-ups", size),
            TaskCard(
              latestTask: controller.leadDetailModel.data?.latestTask?.dueDate !=
                      null
                  ? formatDate1(
                      controller.leadDetailModel.data!.latestTask!.dueDate
                          .toString())
                  : "NA",
              latestFollowUp:
                  controller.leadDetailModel.data?.latestFollowUp?.followUpDate !=
                          null
                      ? formatDate1(controller.leadDetailModel.data!
                          .latestFollowUp!.followUpDate
                          .toString())
                      : "NA",
              leadId: "${controller.leadDetailModel.data?.id}",
            ),
            buildSectionTitle(Icons.share_outlined, "Lead Source", size),
            LeadSourceCard(
              leadSource: controller.leadDetailModel.data?.leadSource?.name ??
                  "NA",
            ),
            buildSectionTitle(
                Icons.person_add_outlined, "Assigned Salesperson", size),
            AssignCard(
              assignTo: controller.leadDetailModel.data?.assignedTo?.name ?? "NA",
              leadId: "${controller.leadDetailModel.data?.id}",
            ),
          ],
        ),
      );
    });
  }

  Widget buildSectionTitle(IconData icon, String title, Size size) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
        ),
        SizedBox(
          width: size.width * .01,
        ),
        Text(title,
            style: GLTextStyles.robotoStyle(size: 16, weight: FontWeight.w500)),
      ],
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
