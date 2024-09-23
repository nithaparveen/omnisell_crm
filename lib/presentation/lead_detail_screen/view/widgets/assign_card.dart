import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            // GestureDetector(
            //   onTap: () {
            //     showModalBottomSheet(
            //       backgroundColor: Colors.white,
            //       context: context,
            //       isScrollControlled: true,
            //       builder: (context) => ReAssignBottomSheet(leadId: leadId),
            //     );
            //   },
            //   child: const Icon(
            //     Icons.compare_arrows,
            //     size: 24,
            //   ),
            // )
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
  String? assignTo;
  String? selectedUserId;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<LeadDetailsController>(context, listen: false)
        .getUsersList(context);
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
                value: assignTo,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      assignTo = newValue;
                      selectedUserId = controller.usersListModel.data
                          ?.firstWhere((user) => user.name == newValue)
                          .id
                          ?.toString();
                    });
                  }
                },
                items: controller.usersListModel.data
                        ?.map<DropdownMenuItem<String>>((user) {
                      return DropdownMenuItem<String>(
                        value: user.name ?? '',
                        child: Text(user.name ?? 'Unknown'),
                      );
                    }).toList() ??
                    [],
                decoration: InputDecoration(
                  labelText: 'Assign To',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Followup Date',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Note',
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
                          .addFollowUp(
                              widget.leadId,
                              dateController.text,
                              selectedUserId ?? '',
                              noteController.text,
                              context);
                      Navigator.of(context).pop();
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
