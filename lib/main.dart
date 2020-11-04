import 'package:flutter/material.dart';
import 'package:todo/providers/task_data.dart';
import 'package:todo/screens/task_manager_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/preferences_data.dart';
import 'package:todo/providers/date_card_data.dart';
import 'package:todo/size_config.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferencesData(),
        ),
        ChangeNotifierProvider(
          create: (_) => DateCardData(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return TaskManagerScreen();
          });
        }),
      ),
    );
  }
}
