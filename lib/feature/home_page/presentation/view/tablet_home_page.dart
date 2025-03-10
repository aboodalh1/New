import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/widgets/tablet/tablet_custom_loading_indicator.dart';
import 'package:qrreader/core/widgets/tablet/tablet_status_cell.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/generate_qr_page_view.dart';
import 'package:qrreader/feature/home_page/presentation/manger/home_cubit.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'package:qrreader/feature/messages/presentation/view/messages_page_view.dart';
import '../../../../constant.dart';
import '../../../../core/util/screen_util.dart';
import '../../../customers/presentation/manger/customer_cubit.dart';

class TabletHomePage extends StatefulWidget {
  const TabletHomePage({ super.key});

  @override
  State<TabletHomePage> createState() => _TabletHomePageState();
}

class _TabletHomePageState extends State<TabletHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TabletHomePageBody(),
    );
  }
}

class TabletHomePageBody extends StatelessWidget {
  const TabletHomePageBody({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is GetReadsLoadingState){
          return const TabletLoadingIndicator();}
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Last Read",style: TextStyle(
                      fontSize: 10.sp
                    ),),
                    SizedBox(width: 130.w,),
                    IconButton(
                        tooltip: 'Refresh',
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          context.read<HomeCubit>().getAllReads();
                        }, icon: Icon(Icons.refresh,size: 10.sp,color:kSecondaryColor,)),
                    IconButton(
                        tooltip: 'Notifications',
                        onPressed: () {
                      navigateTo(context, const MessagePageView());
                    },
                        icon: Icon(Icons.notifications, size: 10.sp,
                          color: kSecondaryColor,)),
                    SizedBox(width: 10.w,),
                    CustomElevatedButton(
                      fill: true,
                      title: 'Generate QR',
                      onPressed: () {
                        context.read<CustomerCubit>().getAllCustomers(role: 'all');
                        navigateTo(context, const GenerateQrPageViw());
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                DataTable(
                    headingRowColor: MaterialStateProperty.all(kPrimaryColor),
                    headingTextStyle: const TextStyle(color: Colors.white),
                    border: const TableBorder(
                      horizontalInside:
                      BorderSide(width: 0.54, color: Colors.black),
                    ),
                    columnSpacing: 10.w,
                    columns: const [
                      DataColumn(
                          label: TabletCustomText(
                            title: 'User name',
                            isHeader: true,
                          )),
                      DataColumn(
                          label: TabletCustomText(
                            title: 'Position',
                            isHeader: true,
                          )),
                      DataColumn(
                          label: TabletCustomText(
                            title: 'Customer Name',
                            isHeader: true,
                          )),
                      DataColumn(
                          label: TabletCustomText(
                            title: 'Bag ID',
                            isHeader: true,
                          )),
                      DataColumn(
                          label: TabletCustomText(
                            title: 'Status',
                            isHeader: true,
                          )),
                      DataColumn(
                          label: TabletCustomText(
                            title: 'Date',
                            isHeader: true,
                          )),
                    ],
                    rows: List.generate(context.read<HomeCubit>().homeReadsModel.data.length,
                            (i) => DataRow(cells: [
                              DataCell(TabletCustomText(
                                  title:context.read<HomeCubit>().homeReadsModel.data[i].userName,
                                  isHeader:false
                              )),
                              DataCell(TabletCustomText(
                                  isHeader:false
                                  ,title:context.read<HomeCubit>().homeReadsModel.data[i].userRole)),
                              DataCell(TabletCustomText(  isHeader:false,
                                  title:context.read<HomeCubit>().homeReadsModel.data[i].customerName)),
                              DataCell(TabletCustomText(  isHeader:false,
                                  title:'${context.read<HomeCubit>().homeReadsModel.data[i].bagId}')),
                              DataCell(TabletStatusCell(
                                title: context.read<HomeCubit>().homeReadsModel.data[i].status=='stored_stage_1'||context.read<HomeCubit>().homeReadsModel.data[i].status=='stored_stage_2'? 'At Store':
                                context.read<HomeCubit>().homeReadsModel.data[i].status=='shipping' && context.read<HomeCubit>().homeReadsModel.data[i].previousState=="stored_stage_2"? 'To Customer':
                                context.read<HomeCubit>().homeReadsModel.data[i].status=='shipping' && context.read<HomeCubit>().homeReadsModel.data[i].previousState=="delivered"? "To Kitchen"
                                    :'Delivered',
                                color: context.read<HomeCubit>().homeReadsModel.data[i].status=='stored_stage_1' ||context.read<HomeCubit>().homeReadsModel.data[i].status=='stored_stage_2'?kAtStoreColor:
                                context.read<HomeCubit>().homeReadsModel.data[i].status=='shipping'?kOnWayColor:kAtCustomerColor,
                              )),
                              DataCell(TabletCustomText(  isHeader:false,
                                  title:context.read<HomeCubit>().homeReadsModel.data[i].date)),
                            ])))
              ],
            ),
          ),
        );
      },
    );
  }
}

class TabletCustomText extends StatelessWidget {
  const TabletCustomText({
    super.key,
    required this.title,
    required this.isHeader,
  });

  final String title;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          color: isHeader ? Colors.white : Colors.black,
          fontSize: 5.0.sp),
    );
  }
}
