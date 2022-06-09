// import 'dart:ui';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remainder_application/database/to_do_database/Controllers/task_controller.dart';
import 'package:remainder_application/database/to_do_database/models/task.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
import 'package:remainder_application/presentation/services/notification_services.dart';
import 'package:remainder_application/presentation/services/theme.dart';
import 'package:remainder_application/presentation/services/theme_services.dart';
import 'package:remainder_application/presentation/user_interface/page_views/remainder_pages/add_task_bar_view.dart';
import 'package:remainder_application/presentation/user_interface/widgets/button.dart';
import 'package:remainder_application/presentation/user_interface/widgets/task_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  final TaskController _taskController = Get.put(TaskController());
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }


  _showTasks(){
    //
    return Expanded(
        child: Obx((){
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_,index){
              Task task = _taskController.taskList[index];
              if(task.repeat == "Daily"){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task,
                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              // if(task.repeat == "weekly"){
              //   DateTime date = DateFormat.jm().parse(task.startTime.toString());
              //   var myTime = DateFormat("HH:mm").format(date);
              //   notifyHelper.scheduledNotification(
              //     int.parse(myTime.toString().split(":")[0]),
              //     int.parse(myTime.toString().split(":")[1]),
              //     task,
              //   );
              //
              //   while(){
              //     return AnimationConfiguration.staggeredList(
              //       position: index,
              //       child: SlideAnimation(
              //         child: FadeInAnimation(
              //           child: Row(
              //             children: [
              //               GestureDetector(
              //                 onTap: (){
              //                   _showBottomSheet(context, task);
              //                 },
              //                 child: TaskTile(task),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   }
              // }
              if(task.date == DateFormat.yMd().format(_selectedDate)){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task,
                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return Container();
              }
          });
        }),
    );
  }

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted==1?
            MediaQuery.of(context).size.height*0.18:
            MediaQuery.of(context).size.height*0.245,
        decoration: BoxDecoration(
          color: Get.isDarkMode?Colors.grey[900]:Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
              ),
            ),
            task.isCompleted==1?Container():
                _bottomSheetButton(
                    label: "Task Completed",
                    onTap: (){
                      _taskController.markToComplete(task.id!);//getTasks() is called inside deleteTasks()
                      Get.back();
                    },
                    color: ColorManager.bottomSheetBlue,
                    context:context
                ),
            _bottomSheetButton(
                label: "Delete Task",
                onTap: (){
                  _taskController.delete(task);//getTasks() is called inside deleteTasks()
                  Get.back();
                },
                color: ColorManager.bottomSheetRed,
                context:context
            ),
            const SizedBox(height: 20,),
            _bottomSheetButton(
                label: "Close",
                onTap: (){
                  Get.back();
                },
                color: ColorManager.bottomSheetClose,
                context:context
            ),
            const SizedBox(height: 5)
          ],
        ),
      )
    );
  }

  _bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color color,
    bool isClose = false,
    required BuildContext context,
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose?Colors.red:color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() => Container(
        margin: const EdgeInsets.all(15),
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: ColorManager.primaryLight,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        ),
      );

  _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: ElevatedBtn(
            padding: const EdgeInsets.all(15),
            label: "+ Add Task",
            onPressed: () async{
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks();
            },
          ),
        ),
      ],
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage:
              AssetImage("assets/images/0f2fee16003f0c101a902763def080a9.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
