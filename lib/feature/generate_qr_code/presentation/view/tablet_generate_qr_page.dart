import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/widgets/desktop/desktop_custom_loading_indicator.dart';
import 'package:qrreader/dashboard.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/add_qr_info_container.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/generated_qr_container.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/widgets/list_of_qrs_container_widget.dart';

import '../../../../constant.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../manger/generate_qr_cubit.dart';

class TabletGenerateQrPage extends StatelessWidget {
  const TabletGenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(builder: (context, state) {
      if (state is GetCustomersLoading) {
        return const DesktopLoadingIndicator();
      }
      if (state is GetCustomersFailure) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Generate QR'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.read<GenerateQrCubit>().clearQr();
                  navigateAndFinish(
                      context,
                      const DashboardPage(
                        startRoute: 'home',
                      ));
                },
              ),
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kSecondaryColor),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 8.h))),
                    onPressed: () {
                      context
                          .read<CustomerCubit>()
                          .getAllCustomers(role: 'all');
                    },
                    child: const Text(
                      "Try again",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )));
      }
      return BlocConsumer<GenerateQrCubit, GenerateQrState>(
        listener: (context, state) {
          if (state is GenerateQrFailureState) {
            customSnackBar(context, state.error);
          }
          //zak2
          if (state is PrintContainerSuccessState) {
            customSnackBar(context, state.message);
            BlocProvider.of<QrsListToDownloadCubit>(context).clearQrData();
            //here when user press print button in the Done interface not generate interface
            if (context.read<GenerateQrCubit>().isGenerateQr) {
              context.read<GenerateQrCubit>().isGenerateQr =
                  !context.read<GenerateQrCubit>().isGenerateQr;
            }
          }
        },
        builder: (context, state) {
          if (state is GenerateQrLoadingState) {
            return Scaffold(
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  width: 100.w,
                  height: 200.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fetching Data",
                        style: TextStyle(
                            fontSize: 10.sp, color: const Color(0xffFFFFFF)),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          GenerateQrCubit generateQrCubit = context.read<GenerateQrCubit>();
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              // Added Scrollable behavior
              child: Padding(
                // Added padding for consistent spacing
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Container(
                      width: 60.w,
                      height: 40,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(23.2),
                      ),
                      child: Center(
                        child: Text(
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
                    //zak hhehhhehhhehhehehehe
                    if (generateQrCubit.isGenerateQr)
                      Column(
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        // alignment: WrapAlignment.center,
                        spacing: 50,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocProvider.value(
                            value: BlocProvider.of<QrsListToDownloadCubit>(
                                context),
                            child: GeneratedQrContainer(
                                isTablet: false,
                                generateQrCubit: generateQrCubit),
                          ),
                          const ListOfQrsContainerWidget(
                              isTablet: true, isMobile: false),
                        ],
                      )
                    else
                      Column(
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        // alignment: WrapAlignment.center,
                        spacing: 50,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AddQrInfoContainer(generateQrCubit: generateQrCubit),
                          const ListOfQrsContainerWidget(
                              isTablet: true, isMobile: false),
                        ],
                      ),
                    // generateQrCubit.isGenerateQr
                    //     ? GeneratedQrContainer(
                    //         isTablet: true, generateQrCubit: generateQrCubit)
                    //     : AddQrInfoContainer(generateQrCubit: generateQrCubit),
                    const SizedBox(height: 20),
                    generateQrCubit.isGenerateQr
                        ? ElevatedButton(
                            onPressed: () {
                              generateQrCubit.clearQr();
                            },
                            style: ButtonStyle(
                              surfaceTintColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
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
                    // generateQrCubit.isGenerateQr
                    //     ?
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            //zak
                            if (BlocProvider.of<QrsListToDownloadCubit>(context)
                                .state
                                .qrList
                                .isNotEmpty) {
                              generateQrCubit.printContainer(context
                                  // bagID: generateQrCubit
                                  //     .generateQrModel.data.bagId,
                                  // name: generateQrCubit
                                  //     .generateQrModel.data.customerName
                                  );
                            } else {
                              customSnackBar(context,
                                  "You haven't generated any QR code yet.",
                                  color: Colors.red);
                            }
                            // zak
                            // generateQrCubit.printContainer(bagID: generateQrCubit.generateQrModel.data.bagId
                            //     ,name: generateQrCubit.generateQrModel.data.customerName);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor),
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
                    // : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
