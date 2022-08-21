import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_cashe_api/controller/task_controller.dart';
import 'package:hive_cashe_api/model/note.dart';
import 'package:hive_cashe_api/model/themes.dart';
import 'package:hive_cashe_api/view/screens/home_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox('DarkMode');
  TaskController controller = Get.put(TaskController());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TaskController controller = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightMode,
      darkTheme: Themes.darkMode,
      themeMode: controller.theme,
      title: 'Flutter Demo',
      home: HomeView(),
    );
  }
}
