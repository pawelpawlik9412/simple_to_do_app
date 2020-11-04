import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_data.dart';
import 'package:todo/size_config.dart';

class TaskCard extends StatelessWidget {
  TaskCard({@required this.id, @required this.taskLabel, @required this.done});

  final int id;
  final String taskLabel;
  final int done;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 1.1,
          horizontal: SizeConfig.widthMultiplier * 3.6),
      width: double.infinity,
      height: SizeConfig.heightMultiplier * 11.1,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: CheckboxListTile(
          activeColor: Colors.tealAccent,
          checkColor: Colors.black,
          onChanged: (value) {
            if (value == true) {
              Provider.of<TaskData>(context, listen: false).updateTask(id, 1);
            } else {
              Provider.of<TaskData>(context, listen: false).updateTask(id, 0);
            }
          },
          value: done == 1 ? true : false,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            taskLabel,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.textMultiplier * 2.2,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
