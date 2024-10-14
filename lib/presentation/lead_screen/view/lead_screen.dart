import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/app_config/app_config.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/custom_icons_icons.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/view/lead_detail_screen.dart';
import 'package:omnisell_crm/presentation/lead_screen/controller/lead_controller.dart';
import 'package:omnisell_crm/presentation/login_screen/view/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  bool isLoading = true; 

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<LeadsController>(context, listen: false)
        .fetchData(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Lead Screen",
          style: GLTextStyles.cabinStyle(
              color: Colors.black, size: 22, weight: FontWeight.w800),
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
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () => logoutConfirmation(),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Consumer<LeadsController>(builder: (context, controller, _) {
          return isLoading
              ? ShimmerEffect(size: size)
              : Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CustomScrollView(
                    slivers: [
                      SliverList.separated(
                        itemCount: controller.leadsModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeadDetailScreen(
                                    leadId:
                                        controller.leadsModel.data?[index].id ??
                                            0),
                              ),
                            ),
                            child: Card(
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Lead Id : ${controller.leadsModel.data?[index].leadUniqueId}",
                                              style: GLTextStyles.cabinStyle(
                                                  size: 13,
                                                  weight: FontWeight.w400,
                                                  color: Colors.blueAccent),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${controller.leadsModel.data?[index].name}",
                                              style: GLTextStyles.cabinStyle(
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.2),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 5),
                                                )
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3,
                                                bottom: 3,
                                                right: 8,
                                                left: 8),
                                            child: Text(
                                              "${controller.leadsModel.data?[index].stage?.name}",
                                              style: GLTextStyles.cabinStyle(
                                                  size: 13,
                                                  weight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(thickness: 0.5),
                                    if (controller.leadsModel.data?[index]
                                            .phoneNumber !=
                                        null)
                                      iconTextRow(CustomIcons.phone_1,
                                          "${controller.leadsModel.data?[index].phoneNumber}"),
                                    if (controller.leadsModel.data?[index]
                                            .whatsappNumber !=
                                        null)
                                      iconTextRow(CustomIcons.whatsapp,
                                          "${controller.leadsModel.data?[index].whatsappNumber}"),
                                    if (controller
                                            .leadsModel.data?[index].city !=
                                        null)
                                      iconTextRow(Icons.pin_drop_rounded,
                                          "${controller.leadsModel.data?[index].city}"),
                                    if (controller.leadsModel.data?[index]
                                            .assignedToOffice?.name !=
                                        null)
                                      iconTextRow(CustomIcons.building,
                                          "${controller.leadsModel.data?[index].assignedToOffice?.name}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }

  Widget iconTextRow(dynamic icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              style: GLTextStyles.openSans(
                  size: 14, weight: FontWeight.w500, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppConfig.token);
    await sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void logoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.cabinStyle(size: 18),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GLTextStyles.cabinStyle(
                  size: 14,
                  color: const Color(0xff468585),
                  weight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xff468585)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                logout(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
