import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_cashe_api/controller/task_controller.dart';
import 'package:hive_cashe_api/model/note.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomTask extends StatefulWidget {
  Task task;
  CustomTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<CustomTask> createState() => _CustomTaskState();
}

class _CustomTaskState extends State<CustomTask> {
  TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.taskController.text = widget.task.text;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:controller.getDarkMode()? Colors.grey.shade800: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            controller.isCompleted(task: widget.task);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Colors.green : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          widget.task.text,
          maxLines: 2,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: controller.getDarkMode()?Colors.white:Colors.black,
            decoration:
                widget.task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          DateFormat('hh:mm a').format(widget.task.createdAt),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: GestureDetector(
          onTap: () {
            controller.deleteTask(task: widget.task);
          },
          child: const Icon(
            Icons.clear,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
