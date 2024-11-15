import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../constant.dart';
import '../../../manger/generate_qr_cubit.dart';

class MobileGeneratedQrContainer extends StatefulWidget {
  const MobileGeneratedQrContainer({
    super.key,
    required this.generateQrCubit,
  });

  final GenerateQrCubit generateQrCubit;

  @override
  State<MobileGeneratedQrContainer> createState() => _MobileGeneratedQrContainerState();
}

class _MobileGeneratedQrContainerState extends State<MobileGeneratedQrContainer> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1));
    context.read<GenerateQrCubit>().printContainer(
        name: widget.generateQrCubit.generateQrModel.data.customerName,
        bagID: widget.generateQrCubit.generateQrModel.data.bagId);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.generateQrCubit.globalKey,
      child: Container(
        height: 380,
        width: 280.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.8),
          border: Border.all(width: 3, color: kPrimaryColor),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 3.36,
                color: Colors.black.withOpacity(0.25))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
              height: 200,
              width: 200,
              child: Center(
                  child: QrImageView(
                    size: 200,
                    data: widget.generateQrCubit.qrData!,
                    version: QrVersions.auto,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.generateQrCubit.selectedCustomer,
                      style:
                      const TextStyle(fontSize: 25.67, fontWeight: FontWeight.w400),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        textAlign: TextAlign.center,
                        'Bag ID: ${widget.generateQrCubit.generateQrModel.data.bagId}',
                        style: const TextStyle(
                            fontSize: 25.67, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
