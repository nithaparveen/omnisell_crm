import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/communication_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/leads_list_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/phone_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/status_list_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/users_list_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/service/lead_detail_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/lead_detail_screen/model/lead_detail_model.dart';

class LeadDetailsController extends ChangeNotifier {
  bool isLoading = false;
  bool isCSLoading = false;
  bool isPSLoading = false;
  bool isStatusLoading = false;
  bool isUsersLoading = false;
  bool isLeadsLoading = false;
  LeadDetailsModel leadDetailModel = LeadDetailsModel();
  CommunicationSummaryModel communicationSummaryModel =
      CommunicationSummaryModel();
  PhoneSummaryModel phoneSummaryModel = PhoneSummaryModel();
  StatusListModel statusListModel = StatusListModel();
  UsersListModel usersListModel = UsersListModel();
  LeadsListModel leadsListModel = LeadsListModel();

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

  getUsersList(context) async {
    isUsersLoading = true;
    notifyListeners();
    log("LeadDetailsController -> getUsersList()");
    await LeadDetailService.getUsersList().then((value) {
      if (value?["data"] != null) {
        usersListModel = UsersListModel.fromJson(value!);
        isUsersLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
        isUsersLoading = false;
      }
      notifyListeners();
    });
  }

  getLeadsList(context) async {
    isLeadsLoading = true;
    notifyListeners();
    log("LeadDetailsController -> getLeadsList()");
    await LeadDetailService.getLeadsList().then((value) {
      if (value?["data"] != null) {
        leadsListModel = LeadsListModel.fromJson(value!);
        isLeadsLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
        isLeadsLoading = false;
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

  addTask(String title, String date, String user, String leadId,
      String description, context) async {
    log("LeadDetailsController -> addTask()");
    await LeadDetailService.addTask(title, date, user, leadId, description)
        .then((value) {
      if (value["data"] != null) {
        // AppUtils.oneTimeSnackBar(value["message"], context: context,textStyle: TextStyle(fontSize: 18));
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }

  addFollowUp(
      String leadId, String date, String user, String note, context) async {
    log("LeadDetailsController -> addFollowUp()");
    await LeadDetailService.addFollowUp(leadId, date, user, note).then((value) {
      if (value["data"] != null) {
        // AppUtils.oneTimeSnackBar(value["message"], context: context,textStyle: TextStyle(fontSize: 18));
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }
}
