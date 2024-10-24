import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class TaskMangerService {
  static Future<Map<String, dynamic>?> fetchData({required int page}) async {
    try {
      var response = await ApiHelper.getData(
        endPoint: "tasks?page=$page",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
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
