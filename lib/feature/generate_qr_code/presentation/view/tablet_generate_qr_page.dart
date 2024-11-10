import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/add_qr_info_container.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/generated_qr_container.dart';

import '../../../../constant.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../manger/generate_qr_cubit.dart';

class TabletGenerateQrPage extends StatelessWidget {
  const TabletGenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenerateQrCubit, GenerateQrState>(
      listener: (context, state) {
        if (state is GenerateQrFailureState) {
          customSnackBar(context, state.error);
        }

      },
      builder: (context, state) {
    if(state is GenerateQrLoadingState ){
    return Scaffold(
      body: Center(child: Container(
        decoration: BoxDecoration(color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10.r)
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        width: 100.w,height: 200.h,child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Fetching Data",style: TextStyle(fontSize: 10.sp,color: const Color(0xffFFFFFF)),),
          SizedBox(height: 20.h,),
          const CircularProgressIndicator(
          color: Colors.white,
          ),
        ],
      ),),),
    );}
        GenerateQrCubit generateQrCubit = context.read<GenerateQrCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView( // Added Scrollable behavior
            child: Padding( // Added padding for consistent spacing
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Container(
                    width: 60.w,
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(23.2),
                    ),
                    child: Center(
                      child:  Text(
                        'Generate QR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 7.sp,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  generateQrCubit.isGenerateQr
                      ? GeneratedQrContainer(generateQrCubit: generateQrCubit)
                      : AddQrInfoContainer(generateQrCubit: generateQrCubit),
                  const SizedBox(height: 20),
                  generateQrCubit.isGenerateQr
                      ? ElevatedButton(
                    onPressed: () {
                      generateQrCubit.clearQr();
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
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    ),
                  )
                      : Container(),
                  const SizedBox(height: 20),
                  generateQrCubit.isGenerateQr
                      ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          generateQrCubit.printContainer(bagID: generateQrCubit.generateQrModel.data.bagId
                              ,name: generateQrCubit.generateQrModel.data.customerName);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.8),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Print',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
