import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_data.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/custom_widgets/calendar_card.dart';
import 'package:todo/custom_widgets/task_list_view.dart';
import 'package:todo/providers/date_card_data.dart';
import 'package:todo/size_config.dart';

class TaskManagerScreen extends StatefulWidget {
  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<TaskData>(context, listen: false).deleteAllPastTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 30 * SizeConfig.heightMultiplier,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35.0),
                  bottomLeft: Radius.circular(35.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 6.7 , bottom:  SizeConfig.heightMultiplier * 2.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Task Manager',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 3.9,
                            color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AddTaskScreen();
                            }),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        iconSize: SizeConfig.textMultiplier * 3.9,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: SizeConfig.heightMultiplier * 13.4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Provider.of<DateCardData>(context)
                        .getNextDays(7)
                        .length,
                    itemBuilder: (BuildContext context, index) {
                      var list = Provider.of<DateCardData>(context)
                          .getNextDays(7)[index];
                      return CalendarCard(
                        fullDate: list.fullDate,
                        weekday: list.shortWeekdayName,
                        dayNumber: list.dayNumber.toString(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TaskListView(),
            ),
          ),
        ],
      ),
    );
  }
}
