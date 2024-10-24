import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/app_config/app_config.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:omnisell_crm/presentation/login_screen/view/login_screen.dart';
import 'package:omnisell_crm/presentation/task_manager_screen/controller/task_manager_controller.dart';
import 'package:omnisell_crm/presentation/task_manager_screen/view/widget/task_detail_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = true;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final controller =
          Provider.of<TaskManagerController>(context, listen: false);
      if (!controller.isMoreLoading && !controller.hasReachedMax) {
        controller.fetchMoreData(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<TaskManagerController>(context, listen: false)
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
          "Task Manager Screen",
          style: GLTextStyles.cabinStyle(
              color: Colors.black, size: 20, weight: FontWeight.w800),
        ),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                builder: (context) => const AddTaskBottomSheet(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: .5)),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "ADD TASK",
                      style: GLTextStyles.cabinStyle(
                          size: 13,
                          weight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
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
        child: isLoading
            ? ShimmerEffect(size: size)
            : RefreshIndicator(
                color: Colors.blueAccent,
                onRefresh: fetchData,
                child: Consumer<TaskManagerController>(
                  builder: (context, controller, _) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index <
                                    (controller.taskManagerModel.data?.length ??
                                        0)) {
                                  return InkWell(
                                    onTap: () => showTaskDetailBottomSheet(
                                      context,
                                      title: controller.taskManagerModel
                                              .data?[index].title ??
                                          'No Title',
                                      lead: controller.taskManagerModel
                                              .data?[index].lead?.name ??
                                          'No Lead',
                                      assignedBy: controller.taskManagerModel
                                              .data?[index].createdBy?.name ??
                                          'Unknown',
                                      dueDate: controller.taskManagerModel
                                                  .data?[index].dueDate !=
                                              null
                                          ? DateFormat('dd-MM-yyyy').format(
                                              controller.taskManagerModel
                                                  .data![index].dueDate!)
                                          : 'No Due Date',
                                      createdBy: controller.taskManagerModel
                                              .data?[index].createdBy?.name ??
                                          'Unknown',
                                      assignedTo: controller
                                              .taskManagerModel
                                              .data?[index]
                                              .assignedToUser
                                              ?.name ??
                                          'Unknown',
                                      createdDate: controller.taskManagerModel
                                                  .data?[index].createdAt !=
                                              null
                                          ? DateFormat('dd-MM-yyyy').format(
                                              controller.taskManagerModel
                                                  .data![index].createdAt!)
                                          : 'No Date',
                                    ),
                                    child: Card(
                                      surfaceTintColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Lead : ${controller.taskManagerModel.data?[index].lead?.name}",
                                                      style: GLTextStyles
                                                          .cabinStyle(
                                                              size: 13,
                                                              weight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .blueAccent),
                                                    ),
                                                    Text(
                                                      "Due Date : ${controller.taskManagerModel.data?[index].dueDate != null ? DateFormat('dd-MM-yyyy').format(controller.taskManagerModel.data![index].dueDate!) : 'No Due Date'}",
                                                      style: GLTextStyles
                                                          .cabinStyle(
                                                              size: 12,
                                                              weight: FontWeight
                                                                  .w400,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      "${controller.taskManagerModel.data?[index].title}",
                                                      style: GLTextStyles
                                                          .cabinStyle(
                                                              size: 16,
                                                              weight: FontWeight
                                                                  .w600,
                                                              color:
                                                                  Colors.black),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blueAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(.2),
                                                          blurRadius: 10,
                                                          offset: const Offset(
                                                              0, 5),
                                                        )
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3,
                                                            bottom: 3,
                                                            right: 8,
                                                            left: 8),
                                                    child: Text(
                                                      "${controller.taskManagerModel.data?[index].status}",
                                                      style: GLTextStyles
                                                          .cabinStyle(
                                                              size: 13,
                                                              weight: FontWeight
                                                                  .w400,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Divider(thickness: 0.5),
                                            if (controller
                                                    .taskManagerModel
                                                    .data?[index]
                                                    .assignedToUser
                                                    ?.name !=
                                                null)
                                              richTextRow("Assign To  : ",
                                                  "${controller.taskManagerModel.data?[index].assignedToUser?.name}"),
                                            if (controller
                                                    .taskManagerModel
                                                    .data?[index]
                                                    .createdBy
                                                    ?.name !=
                                                null)
                                              richTextRow("Created By  : ",
                                                  "${controller.taskManagerModel.data?[index].createdBy?.name}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (controller.isMoreLoading) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Center(
                                      child: Text(
                                        'No more leads to load',
                                        style: GLTextStyles.cabinStyle(
                                            size: 15,
                                            weight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }
                                return null;
                              },
                              childCount:
                                  (controller.taskManagerModel.data?.length ??
                                          0) +
                                      (controller.hasReachedMax ? 1 : 1),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget richTextRow(String value1, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value1,
            style: GLTextStyles.openSans(
                size: 12, weight: FontWeight.w400, color: Colors.black),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value2,
              style: GLTextStyles.openSans(
                  size: 12.5, weight: FontWeight.w500, color: Colors.black),
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

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    super.key,
  });
  @override
  AddTaskBottomSheetState createState() => AddTaskBottomSheetState();
}

class AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String? assignTo;
  String? selectedLeadId;
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
                value: selectedLeadId,
                decoration: InputDecoration(
                  labelText: 'Lead',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedLeadId = newValue;
                  });
                },
                items: controller.leadsListModel.data?.data
                        ?.map<DropdownMenuItem<String>>((lead) {
                      return DropdownMenuItem<String>(
                        value: lead.id?.toString() ?? '',
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
                      if (titileController.text.isEmpty ||
                          dateController.text.isEmpty ||
                          selectedUserId == null ||
                          selectedLeadId == null ||
                          descriptionController.text.isEmpty) {
                        AppUtils.showFlushbar(
                            context: context,
                            message: "Please fill in all the fields",
                            backgroundColor:
                                const Color.fromARGB(255, 255, 0, 0),
                            icon: Icons.error,
                            iconColor: Colors.white);
                      } else {
                        Provider.of<LeadDetailsController>(context,
                                listen: false)
                            .addTask(
                          titileController.text,
                          dateController.text,
                          selectedUserId ?? '',
                          selectedLeadId ?? '',
                          descriptionController.text,
                          context,
                        );
                        Navigator.of(context).pop();
                        AppUtils.showFlushbar(
                          context: context,
                          message: "Task added successfully",
                          backgroundColor:
                              const Color.fromARGB(255, 244, 244, 244),
                          icon: Icons.done,
                        );
                      }
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

void showTaskDetailBottomSheet(
  BuildContext context, {
  required String title,
  required String lead,
  required String assignedBy,
  required String dueDate,
  required String createdBy,
  required String assignedTo,
  required String createdDate,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return TaskDetailBottomSheet(
          title: title,
          lead: lead,
          assignedBy: assignedBy,
          dueDate: dueDate,
          createdBy: createdBy,
          assignedTo: assignedTo,
          createdDate: createdDate);
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
  );
}
