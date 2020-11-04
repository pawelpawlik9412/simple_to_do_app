import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/preferences_data.dart';
import 'package:todo/size_config.dart';

class CalendarCard extends StatelessWidget {
  CalendarCard(
      {@required this.fullDate,
      @required this.weekday,
      @required this.dayNumber});

  final String fullDate;
  final String weekday;
  final String dayNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PreferencesData>(context, listen: false)
            .safeDateCardPreferences(fullDate);
      },
      child: FutureBuilder(
        future: Provider.of<PreferencesData>(context).getDateCardPreferences(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(
                  left: 20.0,
                  bottom: SizeConfig.heightMultiplier * 2.2,
                  top: SizeConfig.heightMultiplier * 2.2),
              decoration: BoxDecoration(
                color: snapshot.data == fullDate
                    ? Colors.tealAccent
                    : Colors.white70,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: SizeConfig.heightMultiplier * 5.6,
              width: SizeConfig.widthMultiplier * 19.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    weekday,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        color: Colors.black),
                  ),
                  Text(
                    dayNumber,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.textMultiplier * 4.5,
                        color: Colors.black),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
