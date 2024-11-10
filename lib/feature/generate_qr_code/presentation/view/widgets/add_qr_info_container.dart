import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return BlocBuilder<GenerateQrCubit, GenerateQrState>(
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
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    width: 55.w,
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
                        hint: Text('Select Customer',
                          style: TextStyle(fontSize: 4.5.sp),),
                        items: dropdownList.map<
                            DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(), onChanged: (value) {
                      generateQrCubit.selectedCustomer = value!;
                    })
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await generateQrCubit.generateQR(context,i: 1);
                  if (state is GenerateQrSuccessState) {
                    generateQrCubit
                      .generateQrSecond(context);
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