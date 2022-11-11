import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo/view/themes.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTab;

  const MyButton({super.key, required this.label, this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 45.0,
        decoration: BoxDecoration(
          color: primaryclr,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  final TextEditingController? controller;
  const MyInputField(
      {super.key,
      required this.hint,
      required this.title,
      this.widget,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52.0,
            margin:const EdgeInsets.only(top: 8.0),
             padding:const EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    readOnly: widget== null? false:true,
                    controller: controller,
                    style: subTitleStyle,
                    cursorColor: Get.isDarkMode? Colors.grey[100]:Colors.grey[600],
                    decoration: InputDecoration(
                      hintText: hint,
                      helperStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.0,
                          color: Theme.of(context).backgroundColor,
                          )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.0,
                          color: Theme.of(context).backgroundColor,
                          )
                      )
                    ),
                  ),
                ),
                widget==null ?Container():Container(child: widget,),

          
              ],
            ),
          )
        ],
      ),
    );
  }
}
