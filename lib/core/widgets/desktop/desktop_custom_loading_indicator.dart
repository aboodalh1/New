import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../constant.dart';
class DesktopLoadingIndicator extends StatelessWidget {
  const DesktopLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 30,
        child: LoadingIndicator(
          indicatorType: Indicator.lineScale,
          colors: [kPrimaryColor,kSecondaryColor],
        ),
      ),
    );
  }
}
