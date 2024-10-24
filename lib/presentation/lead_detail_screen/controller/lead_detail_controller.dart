import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/communication_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/leads_list_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/office_list_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/phone_summary_model.dart';
import 'package:omnisell_crm/repository/api/lead_detail_screen/model/sales_manager_list_model.dart';
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
  bool isOfficeLoading = false;
  bool isLoadingSalesManagers = false;
  LeadDetailsModel leadDetailModel = LeadDetailsModel();
  CommunicationSummaryModel communicationSummaryModel =
      CommunicationSummaryModel();
  PhoneSummaryModel phoneSummaryModel = PhoneSummaryModel();
  StatusListModel statusListModel = StatusListModel();
  UsersListModel usersListModel = UsersListModel();
  LeadsListModel leadsListModel = LeadsListModel();
  OfficeModel officeModel = OfficeModel();
  SalesManagersListModel salesManagersList = SalesManagersListModel();

  fetchData(leadId, context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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

  Future<void> getSalesManagersByOfficeId(
      String officeId, BuildContext context) async {
    isLoadingSalesManagers = true;
    notifyListeners();

    log("LeadDetailsController -> getSalesManagersByOfficeId()");
    await LeadDetailService.fetchSalesManagers(officeId).then((value) {
      if (value?["data"] != null) {
        salesManagersList = SalesManagersListModel.fromJson(value!);
        isLoadingSalesManagers = false;
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Sales Managers",
          context: context,
          bgColor: ColorTheme.red,
        );
        isLoadingSalesManagers = false;
      }
      notifyListeners();
    }).catchError((error) {
      log("Error fetching sales managers: $error");
      AppUtils.oneTimeSnackBar(
        "An error occurred while fetching sales managers",
        context: context,
        bgColor: ColorTheme.red,
      );
      isLoadingSalesManagers = false;
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
    });
  }

  getOfficeList(context) async {
    isUsersLoading = true;
    notifyListeners();
    log("LeadDetailsController -> getOfficeList()");
    await LeadDetailService.getOfficeList().then((value) {
      if (value?["data"] != null) {
        officeModel = OfficeModel.fromJson(value!);
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
    });
  }

  changeStage(leadId, String stageId, context) async {
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

  addCallLog(
      leadId, String type, String dateTime, String summary, context) async {
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

  addTask(String title, String date, String user, leadId, String description,
      context) async {
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

  addFollowUp(leadId, String date, String user, String note, context) async {
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

  reAssign(leadId, String user, String officeId, BuildContext context) async {
    log("LeadDetailsController -> reAssign()");
    try {
      final value = await LeadDetailService.reAssign(leadId, user, officeId);

      // Ensure the widget is still mounted before showing a SnackBar
      if (context.mounted) {
        if (value["data"] != null) {
          // Optionally show success message
          // AppUtils.oneTimeSnackBar(value["message"], context: context, textStyle: TextStyle(fontSize: 18));
        } else {
          AppUtils.oneTimeSnackBar(
            value["message"],
            context: context,
            bgColor: Colors.redAccent,
          );
        }
      }
    } catch (e) {
      log('Error in reAssign: $e');
      if (context.mounted) {
        AppUtils.oneTimeSnackBar(
          'An error occurred while reassigning',
          context: context,
          bgColor: Colors.redAccent,
        );
      }
    }
  }

  sendMail(String subject, String to, String cc, String body, leadId,
      context) async {
    log("LeadDetailsController -> sendMail()");
    await LeadDetailService.sendMail(subject, to, cc, body, leadId)
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
