import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:provider/provider.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen({super.key, required this.leadId});
  final int leadId;

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<LeadDetailsController>(context, listen: false)
        .fetchData(context, widget.leadId);
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            onPressed: fetchData,
            tooltip: "Refresh",
            icon: const Icon(
              CupertinoIcons.refresh_circled,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Consumer<LeadDetailsController>(builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 46, 146, 157),
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              detailCard("title", "addedDate", "lastActive", "email", "phone")
            ],
          ),
        );
      }),
    );
  }

  Widget detailCard(String title, String addedDate, String lastActive,
      String email, String phone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        color: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 90, 90, 213),
                      Color.fromARGB(255, 185, 78, 151),
                    ])),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person_4_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text("title",
                      style: GLTextStyles.cabinStyle(
                          size: 18, weight: FontWeight.w600))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email,
                          style: GLTextStyles.cabinStyle(
                              size: 15, weight: FontWeight.w500)),
                      Text(lastActive,
                          style: GLTextStyles.cabinStyle(
                              size: 15, weight: FontWeight.w500)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phone,
                          style: GLTextStyles.cabinStyle(
                              size: 15, weight: FontWeight.w500)),
                      Text(addedDate,
                          style: GLTextStyles.cabinStyle(
                              size: 15, weight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
