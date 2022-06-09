import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder_application/database/notes_database/Controllers/notes_task_controller.dart';
import 'package:remainder_application/database/notes_database/models/note.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
import 'package:remainder_application/presentation/services/theme_services.dart';
import 'package:remainder_application/presentation/user_interface/page_views/notes_pages/add_notes_view.dart';
import 'package:remainder_application/presentation/user_interface/page_views/notes_pages/edit_notes_view.dart';
import 'package:remainder_application/presentation/user_interface/widgets/button.dart';
import 'package:remainder_application/presentation/user_interface/widgets/note_tile.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({Key? key}) : super(key: key);

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

final NoteController _noteController = Get.put(NoteController());

List<Color> colorList = [
  ColorManager.red,
  ColorManager.green,
  ColorManager.orange
];

class _NotesHomePageState extends State<NotesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ElevatedBtn(
                  onPressed: () async {
                    await Get.to(() => const AddNotesPage());
                    _noteController.getNotes();
                  },
                  label: "+ Add Note",
                  padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: MediaQuery.of(context).size.width * 0.35),
                ),
              ),
              _getNotesInView()
            ],
          ),
        ),
      ),
    );
  }

  _getNotesInView() {
    return Expanded(
      child: Obx(
        () {
          int itemCount = _noteController.noteList.length;
          return GridView.builder(
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0
            ),
            itemBuilder: (BuildContext context, int index) {
              Note note = _noteController.noteList[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() =>  EditNotesPage(id: note.id, note: note));
                      },
                      child: NoteTile(note: note),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _getToEditing() {}

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
