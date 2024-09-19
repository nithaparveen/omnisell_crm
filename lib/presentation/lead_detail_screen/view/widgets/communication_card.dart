import 'package:flutter/material.dart';
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
}
