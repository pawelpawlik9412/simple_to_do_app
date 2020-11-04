import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task.dart';
import 'package:todo/providers/preferences_data.dart';
import 'package:todo/providers/task_data.dart';
import 'package:todo/size_config.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 12.1, right: SizeConfig.widthMultiplier * 12.1, top: SizeConfig.heightMultiplier * 5.6, bottom: SizeConfig.heightMultiplier * 2.2),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Your Task',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              FlatButton(
                color: Colors.tealAccent,
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () async {
                  var date =
                      await Provider.of<PreferencesData>(context, listen: false)
                          .getDateCardPreferences();
                  Provider.of<TaskData>(context, listen: false).addTask(
                    Task(
                      fullDate: date,
                      taskName: _controller.text,
                      done: 0,
                    ),
                  );
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
