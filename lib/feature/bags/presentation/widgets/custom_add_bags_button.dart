import 'package:flutter/material.dart';

import '../../../../../constant.dart';

class CustomAddBagsButton extends StatelessWidget {
  const CustomAddBagsButton({
    super.key, required this.title, required this.onPressed, required this.doneOrCancel, required this.fontSize,
  });
  final String title;
  final bool doneOrCancel;
  final VoidCallback onPressed;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(width: 1.5,color: doneOrCancel? kPrimaryColor:kOnWayColor),
              borderRadius: BorderRadius.circular(10.43),
            ),
          )),
      child:  Text(
        title,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.w300, color: doneOrCancel?kPrimaryColor:kOnWayColor),
      ),
    );
  }
}
