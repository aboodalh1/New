import 'package:flutter/material.dart';
import 'package:qrreader/constant.dart';


void customSnackBar(context,String text,{Color ?color,int? duration}){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 400,
      duration: Duration(seconds:duration??4),
      backgroundColor: color ?? kPrimaryColor,
      content: Text(text, style: const TextStyle(fontSize:18),),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsetsDirectional.all(10),

    ),
  );
}