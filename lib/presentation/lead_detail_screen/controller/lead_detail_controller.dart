import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/communication_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/phone_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/service/lead_detail_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/lead_detail_screen/model/lead_detail_model.dart';

class LeadDetailsController extends ChangeNotifier {
  bool isLoading = false;
  bool isCSLoading = false;
  bool isPSLoading = false;
  LeadDetailsModel leadDetailModel = LeadDetailsModel();
  CommunicationSummaryModel communicationSummaryModel = CommunicationSummaryModel();
  PhoneSummaryModel phoneSummaryModel = PhoneSummaryModel();

  fetchData(leadId, context) async {
    isLoading = true;
    notifyListeners();
    log("LeadDetailsController -> fetchData()");
    await LeadDetailService.fetchDetailData(leadId).then((value) {
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
  fetchCommunicationSummary(leadId, context) async {
    isCSLoading = true;
    notifyListeners();
    log("LeadDetailsController -> fetchCommunicationSummary()");
    await LeadDetailService.fetchCommunicationSummary(leadId).then((value) {
      if (value?["data"] != null) {
        communicationSummaryModel = CommunicationSummaryModel.fromJson(value!);
        isCSLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
        isCSLoading = false;
      }
      notifyListeners();
    });
  }
  fetchPhoneSummary(leadId, context) async {
    isPSLoading = true;
    notifyListeners();
    log("LeadDetailsController -> fetchPhoneSummary()");
    await LeadDetailService.fetchPhoneSummary(leadId).then((value) {
      if (value?["data"] != null) {
        phoneSummaryModel = PhoneSummaryModel.fromJson(value!);
        isPSLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
        isPSLoading = false;
      }
      notifyListeners();
    });
  }
}
