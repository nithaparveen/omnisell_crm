import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/lead_screen/model/lead_model.dart';
import 'package:omnisell_crm/repository/api/lead_screen/service/lead_service.dart';

class LeadsController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  int currentPage = 1;
  LeadsModel leadsModel = LeadsModel();

  Future<void> fetchData(BuildContext context) async {
      isLoading = true;
      currentPage = 1;
      leadsModel = LeadsModel();
      notifyListeners();

      final value = await LeadsService.fetchData(page: currentPage);
      if (value?["data"] != null) {
        leadsModel = LeadsModel.fromJson(value!);
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

  Future<void> fetchMoreProjects(BuildContext context) async {
    if (isMoreLoading) return;
    isMoreLoading = true;
    notifyListeners();

    try {
      currentPage++;
      final value = await LeadsService.fetchData(page: currentPage);
      if (value != null && value["status"] == "success") {
        final moreProjects = LeadsModel.fromJson(value);
        leadsModel.data?.addAll(moreProjects.data ?? []);
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch more data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
    } catch (error) {
      print("Error fetching more projects: $error");
    } finally {
      isMoreLoading = false;
      notifyListeners();
    }
  }
}
