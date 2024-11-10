import 'package:flutter/material.dart';
import 'package:qrreader/constant.dart';

import '../../../../../core/util/screen_util.dart';

class TabletCustomSearchBar extends StatelessWidget {
  const TabletCustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: ScreenSizeUtil.screenWidth * 0.3,
      child: TextFormField(
          cursorRadius: const Radius.circular(21),
          cursorColor: kPrimaryColor,
          style: const TextStyle(height: 1,fontSize: 14),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  )))),
    );
  }
}
