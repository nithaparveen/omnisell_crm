import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_crm/global_widgets/shimmer_effect.dart';
import 'package:omnisell_crm/presentation/task_screen/controller/task_controller.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.leadId});
  final int leadId;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
    await Provider.of<TaskController>(context, listen: false)
        .fetchData(widget.leadId, context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<TaskController>(builder: (context, controller, _) {
      final taskData = controller.taskModel.data;
      return isLoading
          ? ShimmerEffect(size: size)
          : taskData == null || taskData.isEmpty
              ? const Center(
                  child: Text('No data available'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: taskData.length,
                    itemBuilder: (context, index) => Card(
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${taskData[index].title}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,fontSize: 16),
                                ),
                                Text(
                                  taskData[index].assignedToUser?.name ?? 'N/A',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text('${taskData[index].status}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),)
                              ],
                            ),
                            Text(
                              taskData[index].dueDate != null
                                  ? DateFormat('dd-MM-yyyy')
                                      .format(taskData[index].dueDate!)
                                  : 'N/A',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
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
