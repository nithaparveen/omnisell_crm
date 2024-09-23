import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:provider/provider.dart';

class CommunicationCard extends StatelessWidget {
  final String emailSend;
  final String emailReceiveSummary;
  final String phoneInbound;
  final String phoneOutbound;
  final String leadId;

  const CommunicationCard({
    super.key,
    required this.emailSend,
    required this.emailReceiveSummary,
    required this.phoneInbound,
    required this.phoneOutbound,
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => MailBottomSheet(
                                leadId: leadId,
                              ));
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
                          color: const Color.fromARGB(255, 255, 255, 255),
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
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => CalLogBottomSheet(
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
                          color: const Color.fromARGB(255, 255, 255, 255),
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
  final String leadId;

  const CalLogBottomSheet({
    super.key,
    required this.leadId,
  });
  @override
  CalLogBottomSheetState createState() => CalLogBottomSheetState();
}

class CalLogBottomSheetState extends State<CalLogBottomSheet> {
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
              hint: const Text('Select Type'),
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
                    // Combine date and time into a DateTime object
                    DateTime combinedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    // Format the DateTime object
                    String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
                        .format(combinedDateTime);

                    setState(() {
                      _dateTimeController.text = formattedDateTime;
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 16),
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
                    Provider.of<LeadDetailsController>(context, listen: false)
                        .addCallLog(
                            widget.leadId,
                            selectedPhoneType!,
                            _dateTimeController.text,
                            _callSummaryController.text,
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
  }
}

class MailBottomSheet extends StatefulWidget {
  final String leadId;

  const MailBottomSheet({
    super.key,
    required this.leadId,
  });
  @override
  MailBottomSheetState createState() => MailBottomSheetState();
}

class MailBottomSheetState extends State<MailBottomSheet> {
  TextEditingController toController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController bodyFooterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    toController.text = "priyanka@spiderworks.in";
  }

  @override
  void dispose() {
    toController.dispose();
    ccController.dispose();
    subjectController.dispose();
    bodyController.dispose();
    bodyFooterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 10,
          right: 10,
          top: 10),
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: toController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'To',
                    hintText: 'Recipient Email',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ccController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'CC',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Subject',
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Body'),
                TextField(
                  controller: bodyController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: GLTextStyles.cabinStyle(
                          size: 14,
                          color: const Color(0xFF353967),
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF353967)),
                      ),
                      onPressed: () {
                        Provider.of<LeadDetailsController>(context,
                                listen: false)
                            .sendMail(
                                subjectController.text,
                                toController.text,
                                ccController.text,
                                bodyController.text,
                                widget.leadId,
                                context);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
