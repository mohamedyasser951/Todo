import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/controller.dart';
import 'package:todo/model/model.dart';
import 'package:todo/view/themes.dart';
import 'package:todo/view/widgets.dart';

class TaskPage extends StatefulWidget {
  TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  
  final TaskController _taskController = Get.find();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  String selectedDate = DateFormat.yMd().format(DateTime.now()).toString();
  String startTime = DateFormat("hh:mm a").format(DateTime.now());
  String endTime = "9:10 PM";
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedRemind = 5;
  String _SelectedRepeat = 'None';
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _appBar(context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: headingStyle,
            ),
            MyInputField(
              hint: "Enter your Title",
              title: "Title",
              controller: _titleController,
            ),
            MyInputField(
              hint: "Enter your Note",
              title: "Note",
              controller: _noteController,
            ),
            MyInputField(
                hint: selectedDate,
                title: "Date",
                widget: IconButton(
                    onPressed: () {
                      setState(() {
                        _getDateFromUser(context);
                      });
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ))),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                  title: "Start Time",
                  hint: startTime,
                  widget: IconButton(
                      onPressed: () async {
                        await getTimeFromUser(
                            context: context, isStartTime: true);
                      },
                      icon: const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      )),
                )),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                    child: MyInputField(
                  title: "End Time",
                  hint: endTime,
                  widget: IconButton(
                      onPressed: () async {
                        await getTimeFromUser(
                            context: context, isStartTime: false);
                      },
                      icon: const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      )),
                ))
              ],
            ),
            MyInputField(
              hint: "$_selectedRemind minites early",
              title: "Remind",
              widget: DropdownButton(
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0.0),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  onChanged: (newVal) {
                    setState(() {
                      _selectedRemind = int.parse(newVal!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int val) {
                    Value:
                    val.toString();
                    return DropdownMenuItem<String>(
                      child: Text(val.toString()),
                      value: val.toString(),
                    );
                  }).toList()),
            ),
            MyInputField(
              hint: "$_SelectedRepeat",
              title: "Repeat",
              widget: DropdownButton(
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0.0),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  onChanged: (newVal) {
                    setState(() {
                      _SelectedRepeat = newVal!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String val) {
                    Value:
                    val;
                    return DropdownMenuItem<String>(
                      child: Text(val),
                      value: val,
                    );
                  }).toList()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPlatte(),
                  MyButton(
                      label: "Create Task",
                      onTab: () {
                        _validationfunc();
                      }),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  _addTaskToDB() async {
    await _taskController.addTask(
        tasks: Tasks(
      title: _titleController.text,
      note: _noteController.text,
      date: selectedDate,
      startTime: startTime,
      endTime: endTime,
      remind: _selectedRemind,
      repeat: _SelectedRepeat,
      color: selectedColor,
      isComplete: 0,
    ));
  }

  _validationfunc() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      await _addTaskToDB();
      print(_titleController.value);
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are Requireds",
          icon: const Icon(Icons.warning_amber));
    }
  }

  _colorPlatte() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
              (index) => Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: index == 0
                            ? primaryclr
                            : index == 1
                                ? pinkclr
                                : yellowclr,
                        child: selectedColor == index
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 16,
                              )
                            : Container(),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }

  getTimeFromUser({context, required bool isStartTime}) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((value) {
      if (value == null) {
      } else if (isStartTime) {
        setState(() {
          startTime = value.format(context).toString();
        });
      } else if (!isStartTime) {
        setState(() {
          endTime = value.format(context).toString();
        });
      }
    });
  }

  _getDateFromUser(context) async {
    DateTime? _pickerDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2014),
            lastDate: DateTime(2125))
        .then((value) {
      setState(() {
        selectedDate = DateFormat.yMd().format(value!).toString();
      });
    });
  }
}

_appBar(context) {
  return AppBar(
    elevation: 0.0,
    leading: IconButton(
      iconSize: 20.0,
      icon: Icon(
        Icons.arrow_back_ios,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      onPressed: () {
        Get.back();
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
