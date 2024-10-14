import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:provider/provider.dart';

class AssignCard extends StatelessWidget {
  final String assignTo;
  final String leadId;

  const AssignCard({
    super.key,
    required this.assignTo,
    required this.leadId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              radius: 18,
              child: Icon(
                Icons.person_outlined,
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                assignTo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => ReAssignBottomSheet(leadId: leadId),
                );
              },
              child: const Icon(
                Icons.compare_arrows,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReAssignBottomSheet extends StatefulWidget {
  final String leadId;

  const ReAssignBottomSheet({
    super.key,
    required this.leadId,
  });

  @override
  ReAssignBottomSheetState createState() => ReAssignBottomSheetState();
}

class ReAssignBottomSheetState extends State<ReAssignBottomSheet> {
  String? officeId;
  String? assignTo;
  String? selectedUserId;
  String? selectedOfficeId;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<LeadDetailsController>(context, listen: false)
        .getUsersList(context);
    Provider.of<LeadDetailsController>(context, listen: false)
        .getOfficeList(context);
  }

  void _fetchSalesManagers(String officeId) async {
    await Provider.of<LeadDetailsController>(context, listen: false)
        .getSalesManagersByOfficeId(officeId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadDetailsController>(builder: (context, controller, _) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: officeId != null &&
                        controller.officeModel.data
                                ?.any((office) => office.name == officeId) ==
                            true
                    ? officeId
                    : null,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      officeId = newValue;
                      selectedOfficeId = controller.officeModel.data
                          ?.firstWhere((office) => office.name == newValue)
                          .id
                          ?.toString();
                      _fetchSalesManagers(selectedOfficeId!);
                    });
                  }
                },
                items: controller.officeModel.data
                        ?.map<DropdownMenuItem<String>>((office) {
                      return DropdownMenuItem<String>(
                        value: office.name ?? '',
                        child: Text(office.name ?? 'Unknown'),
                      );
                    }).toList() ??
                    [],
                decoration: InputDecoration(
                  labelText: 'Select Branch',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: assignTo != null &&
                        controller.salesManagersList.data
                                ?.any((user) => user.name == assignTo) ==
                            true
                    ? assignTo
                    : null,
                onChanged: controller.isLoadingSalesManagers
                    ? null
                    : (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            assignTo = newValue;
                            selectedUserId = controller.salesManagersList.data
                                ?.firstWhere((user) => user.name == newValue)
                                .id
                                ?.toString();
                          });
                        }
                      },
                items: controller.salesManagersList.data?.isNotEmpty == true
                    ? controller.salesManagersList.data!
                        .map<DropdownMenuItem<String>>((user) {
                        return DropdownMenuItem<String>(
                          value: user.name ?? '',
                          child: Text(user.name ?? 'Unknown'),
                        );
                      }).toList()
                    : [],
                decoration: InputDecoration(
                  labelText: controller.isLoadingSalesManagers
                      ? 'Loading Sales Managers...'
                      : 'Select Sales Manager',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (controller.isLoadingSalesManagers)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: LoadingAnimationWidget.waveDots(
                    color: const Color(0xFF353967),
                    size: 30,
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<LeadDetailsController>(context, listen: false)
                          .reAssign(widget.leadId, selectedUserId ?? '',
                              selectedOfficeId ?? '', context);
                      Navigator.of(context).pop();
                      Provider.of<LeadDetailsController>(context, listen: false)
                          .fetchData(widget.leadId, context);
                      Provider.of<LeadDetailsController>(context, listen: false)
                          .fetchCommunicationSummary(widget.leadId, context);
                      Provider.of<LeadDetailsController>(context, listen: false)
                          .fetchPhoneSummary(widget.leadId, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF353967),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
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
        ),
      );
    });
  }
}
