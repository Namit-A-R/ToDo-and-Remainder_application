// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remainder_application/database/to_do_database/Controllers/task_controller.dart';
import 'package:remainder_application/database/to_do_database/models/task.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
import 'package:remainder_application/presentation/services/theme.dart';
import 'package:remainder_application/presentation/user_interface/widgets/button.dart';
import 'package:remainder_application/presentation/user_interface/widgets/input_field.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedRepeat = "None";

  int _selectedRemind = 5;
  int _selectedColor = 0;

  List<String> repeatList = ["None", "Daily"];// "Weekly", "Monthly", "Yearly"
  List<int> remindList = [5, 10, 15, 20];
  List<Color> colorList = [ColorManager.red, ColorManager.green, ColorManager.orange];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(//Add Task main Heading
                'Add Task',
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your Title",
                controller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your Note",
                controller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ), //Date
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ), //Start Time & End Time
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remainder",
                        style: titleStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 08),
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                        child: DropdownButton<String>(
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue!);
                            });
                          },
                          items: remindList
                              .map<DropdownMenuItem<String>>(
                                (int value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(""
                                      "$value minutes early",
                                        style: TextStyle(
                                          color: Get.isDarkMode?ColorManager.grey:ColorManager.grey,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                          isExpanded: true,
                          alignment: AlignmentDirectional.center,
                          hint: Text("$_selectedRemind minutes early",

                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          style: subTitleStyle,
                          underline: Container(
                            height: 0,
                          ),
                        ),
                      ),
                    ]),
              ), //Remind
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Repeat",
                        style: titleStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 08),
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRepeat = newValue!;
                            });
                          },
                          items: repeatList
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text("$value"),
                                ),
                              )
                              .toList(),
                          isExpanded: true,
                          alignment: AlignmentDirectional.center,
                          hint: Text(_selectedRepeat),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          style: subTitleStyle,
                          underline: Container(
                            height: 0,
                          ),
                        ),
                      ),
                    ]),
              ), //Repeat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ElevatedBtn(
                        padding: const EdgeInsets.all(15),
                          label: "Create Task", onPressed: () => _validateData()))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_noteController.text.isNotEmpty && _titleController.text.isNotEmpty) {
      //add to database
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Empty Fields", "All Fields are required",
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.white,
          animationDuration: null,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.redAccent,
            size: 30,
          ));
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      )
    );
    print("My id is: $value");
  }

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            "Color",
            style: titleStyle,
          ),
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 5),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: colorList[index],
                  child: index == _selectedColor
                      ? Icon(
                          Icons.done,
                          color: ColorManager.white,
                          size: 16,
                        )
                      : null,
                ),
              ),
            ),
          ),
        )
        //1:53:50
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker(isStartTime);
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time cancelled");
    } else if (isStartTime) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (!isStartTime) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker(bool isStartTime) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: isStartTime
            ? int.parse(_startTime.split(":")[0])
            : int.parse(_endTime.split(":")[0]),
        minute: isStartTime
            ? int.parse(_startTime.split(":")[1].split(" ")[0])
            : int.parse(_endTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
