import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/presentation/task_screen/controller/task_controller.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.leadId});
  final String leadId;
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<TaskController>(context, listen: false)
        .fetchData(widget.leadId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (context, controller, _) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor:
                const MaterialStatePropertyAll(Color.fromARGB(255, 10, 49, 82)),
            columns: const [
              DataColumn(
                label: Text(
                  'Title',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Assign To ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Due Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              controller.taskModel.data?.length ?? 0,
              (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text('${controller.taskModel.data?[index].title}')),
                  DataCell(Text(
                                    controller.taskModel.data?[index].assignedToUser?.name ?? 'N/A',
                                ),),
                  DataCell(Text(
                    controller.taskModel.data?[index].dueDate != null
                        ? DateFormat('dd-MM-yyyy')
                            .format(controller.taskModel.data![index].dueDate!)
                        : 'N/A',
                  )),
                  DataCell(Text('${controller.taskModel.data?[index].status}')),
                  // DataCell(const Icon(Icons.edit)),
                ],
              ),
            )),
      );
    });
  }
}
