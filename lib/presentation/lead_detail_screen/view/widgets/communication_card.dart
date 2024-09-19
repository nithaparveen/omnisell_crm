import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';

class CommunicationCard extends StatelessWidget {
  final String emailSend;
  final String emailReceiveSummary;
  final String phoneInbound;
  final String phoneOutbound;

  const CommunicationCard({
    Key? key,
    required this.emailSend,
    required this.emailReceiveSummary,
    required this.phoneInbound,
    required this.phoneOutbound,
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: "  "),
                        const TextSpan(
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: "  "),
                        const TextSpan(
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: "  "),
                        const TextSpan(
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: "  "),
                        const TextSpan(
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => CalLogBottomSheet(),
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
                          "Add Call Log",
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

class CalLogBottomSheet extends StatefulWidget {
  @override
  _CalLogBottomSheetState createState() => _CalLogBottomSheetState();
}

class _CalLogBottomSheetState extends State<CalLogBottomSheet> {
  String? selectedPhoneType;
  final List<String> phoneTypes = ['Inbound', 'Outbound'];

  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _callSummaryController = TextEditingController();

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
              hint: Text('Select Type'),
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
            SizedBox(height: 16),

            // Date and Time Picker
            TextFormField(
              controller: _dateTimeController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Date and Time',
                suffixIcon: Icon(Icons.calendar_today),
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
            SizedBox(height: 16),

            // Call Summary Field
            TextFormField(
              controller: _callSummaryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Call Summary',
              ),
            ),
            SizedBox(height: 16),

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
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Save button logic
                    // Collect data from controllers
                    String? dateTime = _dateTimeController.text;
                    String? callSummary = _callSummaryController.text;

                    // Print or use the collected data
                    print('Phone Type: $selectedPhoneType');
                    print('Date and Time: $dateTime');
                    print('Call Summary: $callSummary');

                    // Close the bottom sheet
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF353967),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
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
