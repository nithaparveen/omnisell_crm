import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class TimeLineService {
  static Future<Map<String, dynamic>?> fetchData(String leadId) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "leads/timeline/$leadId?id=$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchMoreLeads({required int page}) async {
    try {
      var nextPage = "http://be.mandgholidays.com/api/app/lead/list?page=$page";
      var decodedData = await ApiHelper.getDataWObaseUrl(
        endPoint: nextPage,
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      throw Exception('Failed to fetch leads');
    }
  }
}
