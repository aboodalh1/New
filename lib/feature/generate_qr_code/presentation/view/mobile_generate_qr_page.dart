import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/widgets/tablet/tablet_custom_loading_indicator.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/generate_qr_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/mobile/mobile_add_qr_info_container.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/mobile/mobile_generated_qr_container.dart';

import '../../../customers/presentation/manger/customer_cubit.dart';


class MobileGenerateQRPage extends StatelessWidget {
  const MobileGenerateQRPage({super.key});

  @override
  Widget build(BuildContext context){
    return BlocConsumer<CustomerCubit, CustomerState>(
  listener: (context, state) {},
  builder: (context, state) {
    if(state is GetCustomersLoading){
      return Scaffold(
        appBar: AppBar(),
        body: const TabletLoadingIndicator(),
      );
    }
      if(state is GetCustomersFailure){
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context.read<CustomerCubit>().getAllCustomers(role: 'active');
                  },
                  child: const Text('retry'),
                ),
              ],
            ),
          ),
        );
      }
    return BlocConsumer<GenerateQrCubit, GenerateQrState>(
      listener: (context, state) {},
      builder:  (context, state) {
        GenerateQrCubit generateQrCubit = context.read<GenerateQrCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(23.2),
                    ),
                    child: const Text(
                      'Generate QR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  generateQrCubit.isGenerateQr
                      ? MobileGeneratedQrContainer(generateQrCubit: generateQrCubit)
                      : MobileAddQrInfoContainer(generateQrCubit: generateQrCubit),
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
                      'Clear',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    ),
                  )
                      : Container(),
                  const SizedBox(height: 20), // Adjust spacing
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
  },
);
  }
}
