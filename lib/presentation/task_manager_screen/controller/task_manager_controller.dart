import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/task_manager_screen/model/task_manager_model.dart';
import 'package:omnisell_crm/repository/api/task_manager_screen/service/task_manager_service.dart';

class TaskManagerController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  bool hasReachedMax = false;
  int currentPage = 1;
  TaskManagerModel taskManagerModel = TaskManagerModel();

  Future<void> fetchData(BuildContext context) async {
    try {
      isLoading = true;
      currentPage = 1;
      hasReachedMax = false;
      taskManagerModel = TaskManagerModel();
      notifyListeners();

      final value = await TaskMangerService.fetchData(page: currentPage);
      
      if (value != null) {
        taskManagerModel = TaskManagerModel.fromJson(value);
        hasReachedMax = (taskManagerModel.data?.length ?? 0) < 10;
        debugPrint("Initial fetch: Got ${taskManagerModel.data?.length} items");
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
    } catch (error) {
      debugPrint("Error in fetchData: $error");
      AppUtils.oneTimeSnackBar(
        "Error fetching data: $error",
        context: context,
        bgColor: ColorTheme.red,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreData(BuildContext context) async {
    if (isMoreLoading || hasReachedMax) {
      return;
    }

    try {
      isMoreLoading = true;
      notifyListeners();

      currentPage++;

      final value = await TaskMangerService.fetchData(page: currentPage);
      
      if (value != null) { 
        final moreLeads = TaskManagerModel.fromJson(value);
        final newItems = moreLeads.data ?? [];

        if (newItems.isEmpty) {
          hasReachedMax = true;
        } else {
          taskManagerModel.data?.addAll(newItems);
          hasReachedMax = newItems.length < 10;
        }
      } else {
        currentPage--;
        AppUtils.oneTimeSnackBar(
          "Unable to fetch more data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
    } catch (error) {
      currentPage--;
      debugPrint("Error in fetchMoreData: $error");
      AppUtils.oneTimeSnackBar(
        "Error fetching more data: $error",
        context: context,
        bgColor: ColorTheme.red,
      );
    } finally {
      isMoreLoading = false;
      notifyListeners();
    }
  }
}
