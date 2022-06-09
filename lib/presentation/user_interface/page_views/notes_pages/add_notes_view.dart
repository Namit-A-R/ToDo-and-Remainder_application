import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remainder_application/database/notes_database/Controllers/notes_task_controller.dart';
import 'package:remainder_application/database/notes_database/models/note.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
// import 'package:remainder_application/presentation/services/theme.dart';
import 'package:remainder_application/presentation/user_interface/widgets/button.dart';
import 'package:remainder_application/presentation/user_interface/widgets/multi_line_text_field.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final NoteController _notesController = Get.put(NoteController());

  int _selectedColor = 0;
  List<Color> colorList = [ColorManager.red, ColorManager.green, ColorManager.orange];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(children: [
              MultiLineTextField(
                controller: _titleController,
                hint: "Subject",
                width: MediaQuery.of(context).size.width*0.68,
                height: 52,
                title: "Subject",
              ),
              Container(
                height: 80,
                width: 2,
                decoration: BoxDecoration(
                  color: Get.isDarkMode?ColorManager.dashboardWhite:ColorManager.dashboardBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    ElevatedBtn(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      onPressed: () async{
                        _validateData();
                      },
                      label: "Create Note",
                    ),
                    _colorPalette(),
                  ],
                ),
              )
            ]),
            MultiLineTextField(
              controller: _noteController,
              hint: "Enter your note here",
              height: MediaQuery.of(context).size.height * 0.7,
              title: "Note",
            ),
          ],
        ),
      ),
    );
  }

  _validateData(){
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
          ),
      );
    }
  }

  _addTaskToDb()async{
    int value = await _notesController.addNote(
      note: Note(
        title: _titleController.text,
        note: _noteController.text,
        color: _selectedColor,
        isCompleted: 0,
      )
    );
    print(value);

  }

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
}
