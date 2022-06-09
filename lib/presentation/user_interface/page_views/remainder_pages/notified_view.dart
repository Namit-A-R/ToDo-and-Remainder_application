import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remainder_application/presentation/user_interface/page_views/dashboard.dart';

class NotifiedPage extends StatelessWidget {
  final String label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[850] : Colors.white,
        leading: IconButton(
          onPressed: () => Get.to(() => const Dashboard()),
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
        ),
        title: Text(
          label.split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
          child: Center(
            child: Text(
              label.split("|")[1],
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
