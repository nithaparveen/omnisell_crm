import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class FollowUpService {
  static Future<Map<String, dynamic>?> fetchData(String leadId) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "follow-ups/$leadId?id=$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e) {
      return null;
    }
  }
}
