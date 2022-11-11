
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/db.dart';
import 'package:todo/model/model.dart';
import 'package:todo/services/services.dart';
import 'package:todo/services/themeservice.dart';
import 'package:todo/view/Taskpage.dart';
import 'package:todo/view/themes.dart';
import 'package:todo/view/widgets.dart';

import '../controller/controller.dart';

class Home extends StatelessWidget {
  Home({super.key});
  DateTime selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _appBar(context),
      body: GetBuilder<TaskController>(
        builder: (controller) {
          return ListView(
            children: [
              Column(children: [
                _addTaskBar(),
                _selectedDatePicker(),
                Builder(
                  builder: (context) {
                    if (controller.savedData.length != 0) {
                      return savedTasks();
                    } else {
                      return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width - 100),
                        height: 100,
                        width: 100,
                        child: Icon(Icons.menu,size:100,color: primaryclr,),
                     
                      );
                    }
                  },
                ),
              ]),
            ],
          );
        },
      ),
    );
  }

  Widget savedTasks() {
    return GetBuilder<TaskController>(builder: (controller) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.savedData.length,
        itemBuilder: (context, index) => Dismissible(
            onDismissed: ((direction) {
              print("index is ${index}");
              controller.deleteDataFromDB(
                  id: controller.savedData[index]['id']);
            }),
            key: UniqueKey(),
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.elasticInOut,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              height: 100,
              decoration: BoxDecoration(
                color: controller.savedData[index]['color'] == 0
                    ? primaryclr
                    : _taskController.savedData[index]['color'] == 1
                        ? pinkclr
                        : yellowclr,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.savedData[index]['title']}",
                      style: titleStyle.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${_taskController.savedData[index]['startTime']}",
                          style: heroStyle,
                        ),
                        Text(
                          "- ${controller.savedData[index]['endTime']}",
                          style: heroStyle,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: Text(
                        "${controller.savedData[index]['note']}",
                        style: heroStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            )),
      );
    });
  }

  // Widget cardItem() => AnimatedContainer(
  //       duration: const Duration(seconds: 1),
  //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
  //       height: 100,
  //       decoration: BoxDecoration(
  //         color: controller.savedData[index]['color'] == 0
  //             ? primaryclr
  //             : _taskController.savedData[index]['color'] == 1
  //                 ? pinkclr
  //                 : yellowclr,
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "${controller.savedData[index]['title']}",
  //               style: titleStyle.copyWith(color: Colors.white),
  //             ),
  //             SizedBox(
  //               height: 6,
  //             ),
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.access_time,
  //                   color: Colors.white,
  //                 ),
  //                 SizedBox(
  //                   width: 5,
  //                 ),
  //                 Text(
  //                   "${_taskController.savedData[index]['startTime']}",
  //                   style: heroStyle,
  //                 ),
  //                 Text(
  //                   "- ${controller.savedData[index]['endTime']}",
  //                   style: heroStyle,
  //                 )
  //               ],
  //             ),
  //             SizedBox(
  //               height: 6,
  //             ),
  //             Expanded(
  //               child: Text(
  //                 "${controller.savedData[index]['note']}",
  //                 style: heroStyle,
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subHeadingStyle.copyWith(color: Colors.grey),
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Task",
            onTab: () {
              Get.to(() => TaskPage());
            },
          ),
        ],
      ),
    );
  }

  _selectedDatePicker() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20.0),
      child: DatePicker(
        DateTime.now(),
        height: 100.0,
        width: 80.0,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryclr,
        selectedTextColor: Colors.white,
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
        ),
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16.0)),
        onDateChange: (date) {
          selectedDate = date;
        },
      ),
    );
  }

  _appBar(context) {
    TaskController c = Get.find();
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        iconSize: 20.0,
        icon: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        onPressed: () async {
          ThemeService().switchTheme();
        },
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: const CircleAvatar(
            backgroundColor: primaryclr,
            radius: 20.0,
          ),
        )
      ],
    );
  }
}
