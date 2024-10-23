import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/utils/app_utils.dart';
import 'package:omnisell_crm/repository/api/communication_log_screen/model/call_model.dart';
import 'package:omnisell_crm/repository/api/communication_log_screen/model/whatsapp_model.dart';
import 'package:omnisell_crm/repository/api/communication_log_screen/model/email_model.dart';
import 'package:omnisell_crm/repository/api/communication_log_screen/service/communication_service.dart';

class CommunicationController extends ChangeNotifier {
  bool isEmailLoading = false;
  EmailModel emailModel = EmailModel();
  bool isWhatsAppLoading = false;
  WhatsAppModel whatsappModel = WhatsAppModel();
  bool isCallLoading = false;
  CallModel callModel = CallModel();

  Future<void> fetchEmailData( leadId, BuildContext context) async {
    isEmailLoading = true;
    emailModel = EmailModel();
    notifyListeners();

    final value = await CommunicationService.fetchEmailData(leadId.toString());
    if (value?["data"] != null) {
      emailModel = EmailModel.fromJson(value!);
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch Data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }
    isEmailLoading = false;
    notifyListeners();
  }

  Future<void> fetchWhatsAppData(leadId, BuildContext context) async {
    isWhatsAppLoading = true;
    whatsappModel = WhatsAppModel();
    notifyListeners();

    final value = await CommunicationService.fetchWhatsAppData(leadId.toString());
    if (value?["data"] != null) {
      whatsappModel = WhatsAppModel.fromJson(value!);
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch Data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }
    isWhatsAppLoading = false;
    notifyListeners();
  }

  Future<void> fetchCallData(leadId, BuildContext context) async {
    isCallLoading = true;
    callModel = CallModel();
    notifyListeners();

    final value = await CommunicationService.fetchCallData(leadId.toString());
    if (value?["data"] != null) {
      callModel = CallModel.fromJson(value!);
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch Data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }
    isCallLoading = false;
    notifyListeners();
  }

   sendWhatsapp(String message, String to,  leadId,
      context) async {
    await CommunicationService.sendWhatsapp(message, to, leadId.toString())
        .then((value) {
      if (value["data"] != null) {
        // AppUtils.oneTimeSnackBar(value["message"], context: context,textStyle: TextStyle(fontSize: 18));
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }
}
