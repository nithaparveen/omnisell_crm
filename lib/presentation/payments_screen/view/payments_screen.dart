import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/presentation/payments_screen/controller/payment_controller.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.leadId});
  final String leadId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<PaymentController>(context, listen: false)
        .fetchData(widget.leadId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentController>(builder: (context, controller, _) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              const MaterialStatePropertyAll(Color.fromARGB(255, 10, 49, 82)),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                '\$ Amount',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Payment Mode',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Paid Date',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Details',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Creator & Date',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Receipt',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Action',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            controller.paymentModel.data?.length ??
                0, // If no data, length is 0
            (index) => DataRow(
              cells: <DataCell>[
                DataCell(
                    Text('${controller.paymentModel.data?[index].amount}')),
                DataCell(Text(
                    '${controller.paymentModel.data?[index].paymentMode}')),
                DataCell(Text(
                  controller.paymentModel.data?[index].paymentDate != null
                      ? DateFormat('dd-MM-yyyy').format(
                          controller.paymentModel.data![index].paymentDate!)
                      : 'N/A', // Fallback for null date
                )),
                DataCell(
                    Text('${controller.paymentModel.data?[index].details}')),
                DataCell(Text(
                  '${controller.paymentModel.data?[index].createdBy?.name}\n'
                  '${controller.paymentModel.data?[index].createdAt != null ? DateFormat('dd-MM-yyyy').format(controller.paymentModel.data![index].createdAt!) : 'N/A'}',
                )),
                DataCell(const Icon(Icons.attachment)),
                DataCell(const Icon(Icons.edit)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
