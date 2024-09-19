import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';

class TaskCard extends StatelessWidget {
  final String latestTask;
  final String latestFollowUp;

  const TaskCard({
    Key? key,
    required this.latestTask,
    required this.latestFollowUp,
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
                        builder: (context) => AddTaskBottomSheet(),
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
                        builder: (context) => FollowUpBottomSheet(),
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
  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String? assignTo;
  String? leadList;
  final List<String> phoneTypes = ['Inbound', 'Outbound'];

  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside the text fields
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
            
            // Date and Time Picker
            TextFormField(
              controller: _dateTimeController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Date and Time',
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
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
    
                  if (selectedTime != null) {
                    setState(() {
                      _dateTimeController.text =
                          "${selectedDate.toLocal()} ${selectedTime.format(context)}";
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 16),
    
            // Phone Type Dropdown
            DropdownButtonFormField<String>(
              value: assignTo,
              hint: const Text('Assign To'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  assignTo = newValue;
                });
              },
              items: phoneTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
             DropdownButtonFormField<String>(
              value: assignTo,
              hint: const Text('Lead'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  assignTo = newValue;
                });
              },
              items: phoneTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
    
            // Call Summary Field
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
    
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Cancel button logic
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
                    // Save button logic
                    // Collect data from controllers
                    String? dateTime = _dateTimeController.text;
                    String? callSummary = descriptionController.text;
                    
                    // Print or use the collected data
                    print('Phone Type: $assignTo');
                    print('Date and Time: $dateTime');
                    print('Call Summary: $callSummary');
                    
                    // Close the bottom sheet
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
  }
}

class FollowUpBottomSheet extends StatefulWidget {
  @override
  _FollowUpBottomSheetState createState() => _FollowUpBottomSheetState();
}

class _FollowUpBottomSheetState extends State<FollowUpBottomSheet> {
  String? selectedPhoneType;
  final List<String> phoneTypes = ['Inbound', 'Outbound'];

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside the text fields
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Phone Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedPhoneType,
              hint: const Text('Assign To'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  selectedPhoneType = newValue;
                });
              },
              items: phoneTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
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
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
    
                  if (selectedTime != null) {
                    setState(() {
                      dateController.text =
                          "${selectedDate.toLocal()} ${selectedTime.format(context)}";
                    });
                  }
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
    
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Cancel button logic
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
                    // Save button logic
                    // Collect data from controllers
                    String? dateTime = dateController.text;
                    String? callSummary = noteController.text;
                    
                    // Print or use the collected data
                    print('Phone Type: $selectedPhoneType');
                    print('Date and Time: $dateTime');
                    print('Call Summary: $callSummary');
                    
                    // Close the bottom sheet
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
  }
}
