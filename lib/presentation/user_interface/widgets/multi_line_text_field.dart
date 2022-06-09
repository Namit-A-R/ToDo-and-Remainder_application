import 'package:flutter/material.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
import 'package:remainder_application/presentation/services/theme.dart';

class MultiLineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final double height;
  final double? width;
  final String? initialValue;

  const MultiLineTextField(
      {Key? key, required this.controller, required this.hint, required this.height, this.width, required this.title, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          Container(
            height: height,
            width: width??MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 1.0,
            //   ),
            //   borderRadius: BorderRadius.circular(5),
            // ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                initialValue: initialValue??null,
                autofocus: false,
                expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: controller,
                scrollPhysics: const ScrollPhysics(),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: subTitleStyle,
                  border: InputBorder.none,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
