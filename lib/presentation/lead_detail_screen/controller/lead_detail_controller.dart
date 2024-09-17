import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/service/lead_detail_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/lead_detail_screen/model/lead_detail_model.dart';

class LeadDetailsController extends ChangeNotifier {
  bool isLoading = false;
  LeadDetailsModel leadDetailModel = LeadDetailsModel();

  fetchData(leadId, context) async {
    isLoading = true;
    notifyListeners();
    log("LeadDetailController -> fetchDetailData()");
    LeadDetailService.fetchDetailData(leadId).then((value) {
      if (value?["data"] != null) {
        leadDetailModel = LeadDetailsModel.fromJson(value!);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
        isLoading = false;
      }
      notifyListeners();
    });
  }
}
