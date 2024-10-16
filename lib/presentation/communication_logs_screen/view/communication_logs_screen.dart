import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/custom_icons_icons.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:provider/provider.dart';

class CommunicationLogsScreen extends StatefulWidget {
  const CommunicationLogsScreen({super.key, required this.leadId});
    final String leadId;

  @override
  State<CommunicationLogsScreen> createState() =>
      _CommunicationLogsScreenState();
}

class _CommunicationLogsScreenState extends State<CommunicationLogsScreen> {
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
    return Consumer<LeadDetailsController>(
      builder: (context,controller,_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                buildSectionTitle(Icons.email_outlined, "Email Summary", size),
                SizedBox(
                  height: size.width * .01,
                ),
                buildBox("${controller.communicationSummaryModel.data?.emailSendSummary}", "Sent", "${controller.communicationSummaryModel.data?.emailReceiveSummary}", "Recieved", size,
                    const Color.fromARGB(255, 172, 228, 184), Colors.white),
                SizedBox(
                  height: size.width * .02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 230),
                  child: buildSendButton("Send Mail", size, () {
                    showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => MailBottomSheet(
                                leadId: widget.leadId,
                              ));
                  }),
                ),
                buildSectionTitle(CustomIcons.whatsapp, "WhatsApp Summary", size),
                SizedBox(
                  height: size.width * .01,
                ),
                buildBox("${controller.communicationSummaryModel.data?.whatsappSendSummary}", "Sent", "${controller.communicationSummaryModel.data?.whatsappReceiveSummary}", "Recieved", size,
                    const Color.fromARGB(255, 172, 172, 228), Colors.white),
                SizedBox(
                  height: size.width * .02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 200),
                  child: buildSendButton("Send WhatsApp", size, () {
                    showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => WhatsappBottomSheet(
                                leadId: widget.leadId,
                              ));
                  }),
                ),
                buildSectionTitle(CustomIcons.phone_1, "Phone Call Summary", size),
                SizedBox(
                  height: size.width * .01,
                ),
                buildBox("${controller.phoneSummaryModel.data?.callsInbound}", "Inbound", "${controller.phoneSummaryModel.data?.callsOutbound}","Outbound", size,
                    const Color.fromARGB(255, 236, 183, 183), Colors.white),
                SizedBox(
                  height: size.width * .02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 230),
                  child: buildSendButton("Add Call", size, () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => CalLogBottomSheet(
                          leadId: widget.leadId,
                        ),
                      );
                  }),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget buildSectionTitle(IconData icon, String title, Size size) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        SizedBox(
          width: size.width * .01,
        ),
        Text(title,
            style: GLTextStyles.robotoStyle(size: 14, weight: FontWeight.w400)),
      ],
    );
  }

  Widget buildSendButton(String text, Size size, void Function()? onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.blueAccent)),
      child: Text(text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.blueAccent,
          )),
    );
  }

  Widget buildBox(String count1, String label1, String count2, String label2,
      Size size, Color color1, Color color2) {
    return Container(
      height: size.height * .135,
      width: size.width * .85,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 15),
              child: Row(
                children: [
                  Text(count1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(label1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            const VerticalDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
              child: Row(
                children: [
                  Text(count2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(label2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                ],
              ),
            )
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
class WhatsappBottomSheet extends StatefulWidget {
  final String leadId;

  const WhatsappBottomSheet({
    super.key,
    required this.leadId,
  });
  @override
  WhatsappBottomSheetState createState() => WhatsappBottomSheetState();
}

class WhatsappBottomSheetState extends State<WhatsappBottomSheet> {
  TextEditingController toController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    toController.text;
  }

  @override
  void dispose() {
    toController.dispose();
    messageController.dispose();
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
                    labelText: 'Message To',
                    hintText: 'WhatsApp Number',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Message',
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
                        // Provider.of<LeadDetailsController>(context,
                        //         listen: false)
                        //     .sendMail(
                        //         subjectController.text,
                        //         toController.text,
                        //         ccController.text,
                        //         bodyController.text,
                        //         widget.leadId,
                        //         context);
                        // Navigator.of(context).pop();
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
