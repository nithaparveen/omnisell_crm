import 'dart:developer';
import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class LeadDetailService {
  static Future<dynamic> fetchDetailData(leadId) async {
    log("LeadDetailService -> fetchDetailData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "leads/view/$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchCommunicationSummary(leadId) async {
    log("LeadDetailService -> fetchCommunicationSummary()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "communication-log/summary?lead_id=$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchPhoneSummary(leadId) async {
    log("LeadDetailService -> fetchPhoneSummary()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "phone-calls/summary?lead_id=$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchSalesManagers(String officeId) async {
    log("LeadDetailService -> fetchSalesManagers()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "listing/users?office_id=$officeId&role_id=4",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("Error in LeadDetailService -> fetchSalesManagers(): $e");
      return null;
    }
  }

  static Future<dynamic> getStatusList() async {
    log("LeadDetailService -> getStatusList()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "listing/stages",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> getUsersList() async {
    log("LeadDetailService -> getUsersList()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "listing/accessable-users",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> getOfficeList() async {
    log("LeadDetailService -> getOfficeList()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "listing/offices",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> getLeadsList() async {
    log("LeadDetailService -> getLeadsList()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "listing/leads",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> changeStage(leadId, stageId) async {
    log("LeadDetailService -> changeStage()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint: "leads/change-stage?lead_id=$leadId&stage_id=$stageId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> addCallLog(leadId, type, dateTime, summary) async {
    log("LeadDetailService -> addCallLog()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint:
            "phone-calls/store?lead_id=$leadId&type=$type&date_time_of_call=$dateTime&call_summary=$summary",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> addTask(title, date, user, leadId, description) async {
    log("LeadDetailService -> addTask()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint:
            "tasks/store?title=$title&due_date=$date&assigned_to_user_id=$user&lead_id=$leadId&description=$description",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> addFollowUp(leadId, date, user, note) async {
    log("LeadDetailService -> addFollowUp()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint:
            "follow-ups/store?lead_id=$leadId&follow_up_date=$date&assigned_to=$user&note=$note",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> reAssign(leadId, user, officeId) async {
    log("LeadDetailService -> reAssign()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint:
            "leads/re-assign?lead_id=$leadId&user_id=$user&assign_to_office_id=$officeId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> sendMail(subject, to, cc, body, leadId) async {
    log("LeadDetailService -> sendMail()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint:
            "emails/store?subject=$subject&to=$to&message=$body&cc=$cc&lead_id=$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
