import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/task_screen/model/task_model.dart';
import 'package:omnisell_crm/repository/api/task_screen/service/task_service.dart';

class TaskController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  TaskModel taskModel = TaskModel();

  Future<void> fetchData(leadId, BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLoading = true;
      taskModel = TaskModel();
      notifyListeners();

      final value = await TaskService.fetchData(leadId.toString());
      if (value?["data"] != null) {
        taskModel = TaskModel.fromJson(value!);
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
      isLoading = false;
      notifyListeners();
    });
  }
}
