import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/follow_up_screen/model/follow_up_model.dart';
import 'package:omnisell_crm/repository/api/follow_up_screen/service/follow_up_service.dart';

class FollowUpController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  FollowUpModel followUpModel = FollowUpModel();

  Future<void> fetchData(leadId,BuildContext context) async {
    isLoading = true;
    followUpModel = FollowUpModel();
    notifyListeners();

    final value = await FollowUpService.fetchData(leadId.toString());
    if (value?["data"] != null) {
      followUpModel = FollowUpModel.fromJson(value!);
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch Data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
  // Future<void> fetchMoreProjects(BuildContext context) async {
  //   if (isMoreLoading) return;
  //   isMoreLoading = true;
  //   notifyListeners();

  //   try {
  //     currentPage++;
  //     final value = await LeadsService.fetchData(page: currentPage);
  //     if (value != null && value["status"] == "success") {
  //       final moreProjects = LeadsModel.fromJson(value);
  //       timeLineModel.data?.addAll(moreProjects.data ?? []);
  //     } else {
  //       AppUtils.oneTimeSnackBar(
  //         "Unable to fetch more data",
  //         context: context,
  //         bgColor: ColorTheme.red,
  //       );
  //     }
  //   } catch (error) {
  //     print("Error fetching more projects: $error");
  //   } finally {
  //     isMoreLoading = false;
  //     notifyListeners();
  //   }
  // }

