import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final String latestTask;
  final String latestFollowUp;
  final String leadId;

  const TaskCard({
    Key? key,
    required this.latestTask,
    required this.latestFollowUp,
    required this.leadId,
  }) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Task",
                  style: GLTextStyles.cabinStyle(
                      size: 14, weight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(latestTask),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => AddTaskBottomSheet(
                          leadId: leadId,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 5,
                              offset: const Offset(0, 8),
                            )
                          ],
                          color: Color.fromARGB(255, 255, 255, 255),
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
                    ),
                  )
                ],
              ),
              Text("Follow-up",
                  style: GLTextStyles.cabinStyle(
                      size: 14, weight: FontWeight.w400)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(latestFollowUp),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            FollowUpBottomSheet(leadId: leadId),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 5,
                              offset: const Offset(0, 8),
                            )
                          ],
                          color: Color.fromARGB(255, 255, 255, 255),
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
}

class AddTaskBottomSheet extends StatefulWidget {
  final String leadId;

  const AddTaskBottomSheet({
    super.key,
    required this.leadId,
  });
  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String? assignTo;
  String? selectedLead;
  String? selectedUserId;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titileController = TextEditingController();
  final TextEditingController assignToController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<LeadDetailsController>(context, listen: false)
        .getUsersList(context);
    Provider.of<LeadDetailsController>(context, listen: false)
        .getLeadsList(context);
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
              TextFormField(
                controller: titileController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Title',
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
                  labelText: 'Due Date',
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
              DropdownButtonFormField<String>(
                value: selectedLead,
                decoration: InputDecoration(
                  labelText: 'Lead',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedLead = newValue;
                  });
                },
                items: controller.leadsListModel.data?.data
                        ?.map<DropdownMenuItem<String>>((lead) {
                      return DropdownMenuItem<String>(
                        value: lead.name ?? '',
                        child: Text(lead.name ?? 'Unknown'),
                      );
                    }).toList() ??
                    [],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Description',
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
                          .addTask(
                              titileController.text,
                              dateController.text,
                              selectedUserId ?? '',
                              widget.leadId,
                              descriptionController.text,
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

class FollowUpBottomSheet extends StatefulWidget {
  final String leadId;

  const FollowUpBottomSheet({
    super.key,
    required this.leadId,
  });
  @override
  _FollowUpBottomSheetState createState() => _FollowUpBottomSheetState();
}

class _FollowUpBottomSheetState extends State<FollowUpBottomSheet> {
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
