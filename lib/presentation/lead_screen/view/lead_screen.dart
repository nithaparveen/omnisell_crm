import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final controller = Provider.of<LeadsController>(context, listen: false);
      if (!controller.isMoreLoading && !controller.hasReachedMax) {
        controller.fetchMoreData(context);
      }
    }
  }

  Future<void> fetchData() async {
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
              color: Colors.black, size: 20, weight: FontWeight.w800),
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () => logoutConfirmation(),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<LeadsController>(builder: (context, controller, _) {
          return isLoading
              ? ShimmerEffect(size: size)
              : RefreshIndicator(
                  color: Colors.blueAccent,
                  onRefresh: fetchData,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index <
                                  (controller.leadsModel.data?.length ?? 0)) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: buildLeadCard(controller, index),
                                );
                              } else if (controller.isMoreLoading) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: LoadingAnimationWidget
                                        .horizontalRotatingDots(
                                      color: Colors.blueAccent,
                                      size: 32,
                                    ),
                                  ),
                                );
                              } else if (controller.hasReachedMax) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: Text('No more leads to load',
                                        style: GLTextStyles.cabinStyle(
                                            size: 15,
                                            weight: FontWeight.w400,
                                            color: Colors.black)),
                                  ),
                                );
                              }
                              return null;
                            },
                            childCount:
                                (controller.leadsModel.data?.length ?? 0) +
                                    (controller.hasReachedMax ? 1 : 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Widget buildLeadCard(LeadsController controller, int index) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeadDetailScreen(
              leadId: controller.leadsModel.data?[index].id ?? 0),
        ),
      ),
      child: Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
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
              buildContactInfo(controller, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactInfo(LeadsController controller, int index) {
    return Column(
      children: [
        if (controller.leadsModel.data?[index].phoneNumber != null)
          iconTextRow(CustomIcons.phone_1,
              "${controller.leadsModel.data?[index].phoneNumber}"),
        if (controller.leadsModel.data?[index].whatsappNumber != null)
          iconTextRow(CustomIcons.whatsapp,
              "${controller.leadsModel.data?[index].whatsappNumber}"),
        if (controller.leadsModel.data?[index].city != null)
          iconTextRow(Icons.pin_drop_rounded,
              "${controller.leadsModel.data?[index].city}"),
        if (controller.leadsModel.data?[index].assignedToOffice?.name != null)
          iconTextRow(CustomIcons.building,
              "${controller.leadsModel.data?[index].assignedToOffice?.name}"),
      ],
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
