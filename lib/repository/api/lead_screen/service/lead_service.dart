import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';
import 'package:flutter/material.dart';

class LeadsService {
  static Future<Map<String, dynamic>?> fetchData({required int page}) async {
    try {
      final token = await AppUtils.getToken();
      final headers = ApiHelper.getApiHeader(access: token);
      
      var response = await ApiHelper.getData(
        endPoint: "leads?page=$page",
        header: headers,
      );
      
      
      if (response is Map<String, dynamic>) {
        return response;
      } else {
        debugPrint("Invalid response format: $response");
        return null;
      }
    } catch (e) {
      debugPrint("Error in LeadsService.fetchData: $e");
      return null;
    }
  }
}