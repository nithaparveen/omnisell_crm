import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/payment_screeen/model/payment_model.dart';
import 'package:omnisell_crm/repository/api/payment_screeen/service/payment_service.dart';

class PaymentController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  PaymentModel paymentModel = PaymentModel();

  Future<void> fetchData(leadId, BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLoading = true;
      paymentModel = PaymentModel();
      notifyListeners();

      final value = await PaymentService.fetchData(leadId.toString());
      if (value?["data"] != null) {
        paymentModel = PaymentModel.fromJson(value!);
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
      isLoading = false;
      notifyListeners();
    });
  } 
}
