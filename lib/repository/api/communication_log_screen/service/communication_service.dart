import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class CommunicationService {
  static Future<Map<String, dynamic>?> fetchEmailData(String leadId) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "communication-log?lead_id=$leadId&type[]=Mail&type[]=Mail+Send",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e) {
      return null;
    }
  }
  static Future<Map<String, dynamic>?> fetchWhatsAppData(String leadId) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "communication-log?lead_id=$leadId&type[]=Whatsapp+Send&type[]=Whatsapp",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e) {
      return null;
    }
  }
  static Future<Map<String, dynamic>?> fetchCallData(String leadId) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "phone-calls/$leadId?lead_id=$leadId&type[]=Inbound&type[]=Outbound",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e) {
      return null;
    }
  }
  
   static Future<dynamic> sendWhatsapp(message, to, leadId) async {
    try {
      var decodedData = await ApiHelper.postData(
        endPoint:
            "whatsapp/store?to=$to&message=$message&lead_id=$leadId&template_id=10",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      return null;
    }
  }
}
