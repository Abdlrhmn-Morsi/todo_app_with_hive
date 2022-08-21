import 'package:hive_cashe_api/view/widgets/custom_task.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_cashe_api/model/note.dart';

class TaskController extends GetxController {
  final GlobalKey<AnimatedListState> key = GlobalKey();
  final taskController = TextEditingController();
  static const task = 'tasks';
  final Box<Task> box = Hive.box(task);

  Future<void> createTask(date, text) async {
    Task task = Task(
      id: const Uuid().v1(),
      text: text,
      createdAt: date ?? DateTime.now(),
      isCompleted: false,
    );
    await box.put(task.id, task);
    key.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 300),
    );
    update();
  }

  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  Future<void> isCompleted({required Task task}) async {
    await task.save();
    update();
  }

  Future<void> updateTask({id, text, isCompleted, createdAt}) async {
    Task task = Task(
      id: id,
      text: text,
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
    await task.save();
    update();
  }

  Future<void> deleteTask({required Task task}) async {
    await task.delete();
    key.currentState!.removeItem(
      0,
      ((context, animation) => SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: CustomTask(task: task),
          )),
      duration: const Duration(milliseconds: 300),
    );
    update();
  }

  //////////////////////DARKMODE///////////////////////
  /////////////////////////////////////////////////////
  static const darkMode = 'DarkMode';
  final darkBox = Hive.box(darkMode);

  Future<void> putDarkMode(isDarkMode) => darkBox.put('isDarkMode', isDarkMode);
  getDarkMode() => darkBox.get('isDarkMode') ?? false;

  ThemeMode get theme => getDarkMode() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(getDarkMode() ? ThemeMode.light : ThemeMode.dark);
    putDarkMode(!getDarkMode());
    update();
  }
}
