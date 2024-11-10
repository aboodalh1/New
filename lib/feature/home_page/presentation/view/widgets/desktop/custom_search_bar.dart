import 'package:flutter/material.dart';

import '../../../../../../core/util/screen_util.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key, required this.onChanged,
  });
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeUtil.screenHeight * 0.060<120?70: ScreenSizeUtil.screenHeight * 0.060,
      width: ScreenSizeUtil.screenWidth * 0.32,
      child: TextFormField(
        onChanged: onChanged,
        style: const TextStyle(height: 1.2),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
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
