import 'package:flutter/material.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
import 'package:remainder_application/presentation/user_interface/page_views/notes_pages/notes_home_view.dart';
import 'package:remainder_application/presentation/user_interface/page_views/remainder_pages/rem_home_view.dart';
import 'package:remainder_application/presentation/user_interface/widgets/navigation/custom_animated_bottom_bar.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;
  final _inactiveColor = ColorManager.disabledColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('To-Do-List'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.book),
          title: Text('Notes'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      NotesHomePage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}

