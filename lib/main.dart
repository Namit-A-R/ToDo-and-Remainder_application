import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remainder_application/database/notes_database/notes_db_helper.dart';
import 'package:remainder_application/presentation/services/theme.dart';
import 'package:remainder_application/presentation/services/theme_services.dart';
import 'package:remainder_application/presentation/user_interface/page_views/dashboard.dart';
import 'package:remainder_application/presentation/user_interface/page_views/login_pages/login_view.dart';
import 'database/to_do_database/todo_db_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotesDBHelper.initDb();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,

        home: AuthScreen()
    );
  }
}


