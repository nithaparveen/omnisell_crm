import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/communication_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/phone_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/status_list_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/service/lead_detail_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/lead_detail_screen/model/lead_detail_model.dart';

class LeadDetailsController extends ChangeNotifier {
  bool isLoading = false;
  bool isCSLoading = false;
  bool isPSLoading = false;
  bool isStatusLoading = false;
  LeadDetailsModel leadDetailModel = LeadDetailsModel();
  CommunicationSummaryModel communicationSummaryModel =
      CommunicationSummaryModel();
  PhoneSummaryModel phoneSummaryModel = PhoneSummaryModel();
  StatusListModel statusListModel = StatusListModel();

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

  getStatusList(context) async {
    isStatusLoading = true;
    notifyListeners();
    log("LeadDetailsController -> getStatusList()");
    await LeadDetailService.getStatusList().then((value) {
      if (value?["data"] != null) {
        statusListModel = StatusListModel.fromJson(value!);
        isStatusLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
        isStatusLoading = false;
      }
      notifyListeners();
    });
  }

  changeStage(String leadId, String stageId, context) async {
    log("LeadDetailsController -> changeStage()");
    await LeadDetailService.changeStage(leadId, stageId).then((value) {
      if (value["message"] == "Lead stage successfully changed.") {
        // AppUtils.oneTimeSnackBar(value["message"], context: context,textStyle: TextStyle(fontSize: 18));
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }

  addCallLog(String leadId, String type, String dateTime, String summary,
      context) async {
    log("LeadDetailsController -> addCallLog()");
    await LeadDetailService.addCallLog(leadId, type, dateTime, summary)
        .then((value) {
      if (value["data"] != null) {
        // AppUtils.oneTimeSnackBar(value["message"], context: context,textStyle: TextStyle(fontSize: 18));
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }
}
