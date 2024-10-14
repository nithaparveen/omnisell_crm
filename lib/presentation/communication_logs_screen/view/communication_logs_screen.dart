import 'package:flutter/material.dart';

class CommunicationLogsScreen extends StatefulWidget {
  const CommunicationLogsScreen({super.key});

  @override
  State<CommunicationLogsScreen> createState() => _CommunicationLogsScreenState();
}

class _CommunicationLogsScreenState extends State<CommunicationLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text("CommunicationLogsScreen")],
    );
  }
}
