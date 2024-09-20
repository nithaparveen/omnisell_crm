import 'dart:developer';
import 'package:flutter/foundation.dart';

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

  static Future<dynamic> changeStage(leadId, stageId) async {
    log("LeadDetailService -> assignchangeStageedToTapped()");
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
    log("LeadDetailService -> assignchangeStageedToTapped()");
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
}
