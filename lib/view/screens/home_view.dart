import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_cashe_api/controller/task_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_cashe_api/view/widgets/custom_app_bar.dart';
import 'package:hive_cashe_api/view/widgets/custom_task.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      builder: (controller) => Scaffold(
        backgroundColor: controller.getDarkMode()
            ? Colors.grey.shade900
            : Colors.grey.shade100,
        body: Column(
          children: [
            const SizedBox(height: 30),
            //appbar
            CustomAppBar(
              add: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: Get.width,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
                        leading: const Icon(
                          Icons.subdirectory_arrow_right_outlined,
                        ),
                        trailing: const Icon(
                          Icons.watch_later_outlined,
                        ),
                        title: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter task',
                          ),
                          onSubmitted: (value) {
                            Navigator.pop(context);
                            DatePicker.showTimePicker(
                              context,
                              currentTime: DateTime.now(),
                              showSecondsColumn: false,
                              showTitleActions: true,
                              onConfirm: (date) {
                                if (value.isNotEmpty) {
                                  controller.createTask(date, value);
                                }
                              },
                            );
                          },
                          autofocus: true,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            //content
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedList(
                key: controller.key,
                initialItemCount: controller.box.values.length,
                itemBuilder: (context, i, animation) {
                  var tasks = controller.box.values.toList();
                  tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                  var task = tasks[i];
                  return SizeTransition(
                    key: UniqueKey(),
                    sizeFactor: animation,
                    child: GestureDetector(
                      onTap: () {
                        controller.taskController.text = task.text;
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: Get.width,
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ListTile(
                                title: TextField(
                                  controller: controller.taskController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Edite task'),
                                  onSubmitted: (value) {
                                    Navigator.pop(context);
                                    DatePicker.showTimePicker(
                                      context,
                                      currentTime: DateTime.now(),
                                      showSecondsColumn: false,
                                      showTitleActions: true,
                                      onConfirm: (date) {
                                        task.text =
                                            controller.taskController.text;
                                        controller.updateTask(
                                          id: task.id,
                                          text: task.text,
                                          isCompleted: task.isCompleted,
                                          createdAt: date,
                                        );
                                        setState(() {});
                                      },
                                    );
                                  },
                                  autofocus: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: CustomTask(
                        task: task,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
