import 'package:get/get.dart';
import 'package:remainder_application/database/to_do_database/todo_db_helper.dart';
import '../models/task.dart';

final TaskController taskController = Get.put(TaskController());

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }

  var taskList = <Task>[].obs;

  void getTasks() async{
    print("get tasks called");
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();
  }

  void markToComplete(int id){
    DBHelper.markToComplete(id);
    getTasks();
  }

  TaskController(){
    getTasks();
  }

}