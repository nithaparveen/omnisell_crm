import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class PaymentService {
  static Future<Map<String, dynamic>?> fetchData(String leadId) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "payments?lead_id=$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e) {
      return null;
    }
  }
}
