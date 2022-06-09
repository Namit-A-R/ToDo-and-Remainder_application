import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder_application/database/notes_database/models/note.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';

class NoteTile extends StatelessWidget {

  final Note note;

  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(note.color ?? 0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title.toString(),
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 15, color: ColorManager.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: ColorManager.dashboardWhite,
            ),
            SingleChildScrollView(
              child: Text(
                note.note.toString(),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 13, color: ColorManager.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return ColorManager.red;
      case 1:
        return ColorManager.green;
      case 2:
        return ColorManager.orange;
      default:
        return Colors.lightGreen;
    }
  }
}
