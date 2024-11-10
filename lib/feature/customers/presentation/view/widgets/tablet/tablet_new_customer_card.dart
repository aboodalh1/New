import 'package:flutter/material.dart';

import '../../../../../../constant.dart';

class TabletNewCustomerCard extends StatelessWidget {
  const TabletNewCustomerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      padding:
      const EdgeInsets.only(right: 10, left: 10, top: 35.32, bottom: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14.83)),
          border: Border.all(color: kPrimaryColor, width: 2),
          color: Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kSecondaryColor),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add a new customer',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
