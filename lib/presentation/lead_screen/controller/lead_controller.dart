import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/lead_screen/model/lead_model.dart';
import 'package:omnisell_crm/repository/api/lead_screen/service/lead_service.dart';

class LeadsController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  bool hasReachedMax = false;
  int currentPage = 1;
  LeadsModel leadsModel = LeadsModel();

  Future<void> fetchData(BuildContext context) async {
    try {
      isLoading = true;
      currentPage = 1;
      hasReachedMax = false;
      leadsModel = LeadsModel();
      notifyListeners();

      final value = await LeadsService.fetchData(page: currentPage);
      
      if (value != null) {
        leadsModel = LeadsModel.fromJson(value);
        hasReachedMax = (leadsModel.data?.length ?? 0) < 10;
        debugPrint("Initial fetch: Got ${leadsModel.data?.length} items");
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

      final value = await LeadsService.fetchData(page: currentPage);
      
      if (value != null) {
        final moreLeads = LeadsModel.fromJson(value);
        final newItems = moreLeads.data ?? [];

        if (newItems.isEmpty) {
          hasReachedMax = true;
        } else {
          leadsModel.data?.addAll(newItems);
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