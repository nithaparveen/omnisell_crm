import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/payments_screen/controller/payment_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.leadId});
  final int leadId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<PaymentController>(context, listen: false)
        .fetchData(widget.leadId, context);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _openReceiptFile(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<PaymentController>(builder: (context, controller, _) {
      final paymentData = controller.paymentModel.data;
      return isLoading
          ? ShimmerEffect(size: size)
          : paymentData == null || paymentData.isEmpty
              ? const Center(
                  child: Text('No data available'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: paymentData.length,
                    itemBuilder: (context, index) => Card(
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$ Amount : ${paymentData[index].amount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Payment Mode: ${paymentData[index].paymentMode}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            Text(
                              '${paymentData[index].createdBy?.name}\n'
                              '${paymentData[index].createdAt != null ? DateFormat('dd-MM-yyyy').format(paymentData[index].createdAt!) : 'N/A'}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            IconButton(
                              onPressed: () {
                                final receiptUrl =
                                    paymentData[index].receiptFile;
                                if (receiptUrl != null) {
                                  _openReceiptFile(receiptUrl);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No receipt available'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.attachment),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
    });
  }
}
