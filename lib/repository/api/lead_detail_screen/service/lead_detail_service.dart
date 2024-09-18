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
}