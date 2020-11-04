import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/custom_widgets/task_card.dart';
import 'package:todo/providers/task_data.dart';
import 'package:todo/model/task.dart';
import 'package:todo/size_config.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: Provider.of<TaskData>(context).getTaskForCurrentDay(context),
        builder: (context, AsyncSnapshot snapshot) {
          var list = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, index) {
                  var task = list[index];
                  return Dismissible(
                    key: Key(task.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      try {
                        Provider.of<TaskData>(context, listen: false)
                            .deleteTask(task.id);
                        list.removeAt(index);
                      } catch (e) {
                        print(e);
                      }
                    },
                    background: Container(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 7.2),
                      color: Colors.redAccent,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: SizeConfig.textMultiplier * 2.8,
                          ),
                        ),
                      ),
                    ),
                    child: TaskCard(
                      id: task.id,
                      taskLabel: task.taskName,
                      done: task.done,
                    ),
                  );
                });
          } else {
            return Container();
          }
        });
  }
}
