import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/generate_qr_code/data/model/generate_qr_model.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';

import '../../../../../constant.dart';
import '../../manger/generate_qr_cubit.dart';

class AddQrInfoContainer extends StatelessWidget {
  const AddQrInfoContainer({
    super.key,
    required this.generateQrCubit,
  });

  final GenerateQrCubit generateQrCubit;

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<GenerateQrCubit, GenerateQrState>(
        listener: (context, state) {
        },
        builder: (context, state) {
        return Container(
          height: 420,
          width: 160.w,
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
                decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
                height: 200,
                width: 200,
                child: const Center(
                    child: Text(
                  "Fill the Fields to generate QR",
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xffF2F2F2),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xffF2F2F2),
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xffF2F2F2),
                        ),
                        isExpanded: true,
                        hint: Text(
                          'Select Customer',
                          style: TextStyle(fontSize: 4.5.sp),
                        ),
                        items: dropdownList.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 4.5.sp),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                  )
                                ],
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          generateQrCubit.selectedCustomer = value!;
                        })),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (BlocProvider.of<QrsListToDownloadCubit>(context)
                          .state
                          .qrList
                          .length ==
                      12) {
                    customSnackBar(context,
                        "You have reached the maximum number of QRs on the page, please download the file and try again later.",
                        color: Colors.red);
                  } else if (generateQrCubit.selectedCustomer == "" ||
                      generateQrCubit.selectedCustomer == null) {
                    customSnackBar(
                        context, "You have not selected a customer yet.",
                        color: Colors.red);
                  } else {
                    await generateQrCubit.generateQR(context, i: 1);

                    if (state is GenerateQrSuccessState) {
                      generateQrCubit.generateQrSecond(context);
                    }
                  }
                },
                style: ButtonStyle(
                    surfaceTintColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(16.34),
                      ),
                    )),
                child: const Text(
                  'Generate',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
