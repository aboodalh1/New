import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'package:qrreader/feature/messages/presentation/manger/messages_cubit.dart';

class TabletMessageItem extends StatelessWidget {
  const TabletMessageItem({super.key, required this.messagesCubit, required this.index});
  final MessagesCubit messagesCubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              textAlign: TextAlign.center,
              messagesCubit.allMessagesModel.data[index].type=='issue'?'Issue':
            messagesCubit.allMessagesModel.data[index].type=='register'?"Registeration":"Different read",style: TextStyle(
                color: kSecondaryColor,fontWeight: FontWeight.w500,fontSize: 6.sp
            ),),
                SizedBox(
                    width: 200.w,
                    child: Text(
                      messagesCubit.allMessagesModel.data[index].message,style: TextStyle(fontSize: 6.sp),)),
                Text(messagesCubit.allMessagesModel.data[index].sender??'',style: TextStyle(fontSize: 6.sp),),
              ],
            ),
            const Spacer(),
            Text(messagesCubit.allMessagesModel.data[index].createdAt,style: TextStyle(fontSize: 5.sp),),
          ],
        ),
      );

  }
}

class TabletUnverifiedItem extends StatefulWidget {
  const TabletUnverifiedItem({
    super.key,
    required this.messagesCubit,
    required this.index,
  });
  final MessagesCubit messagesCubit;
  final int index;

  @override
  State<TabletUnverifiedItem> createState() => _TabletUnverifiedItemState();
}

class _TabletUnverifiedItemState extends State<TabletUnverifiedItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessagesCubit, MessagesState>(
      listener: (context, state) {
        if(state is AcceptUserLoading || state is RejectUserLoading){
          setState(() {
            isLoading = true;
          });
        }else if(state is AcceptUserSuccess || state is RejectUserSuccess){
          setState(() {
            isLoading = false;
          });
        }else if(state is AcceptUserFailure || state is RejectUserFailure){
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 10.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.messagesCubit.allUnverifiedModel.data[widget.index].role,style: TextStyle(
                    color: kPrimaryColor,fontWeight: FontWeight.w500,fontSize: 6.sp
                ),),
                Text(widget.messagesCubit.allUnverifiedModel.data[widget.index].name,style: TextStyle(fontSize:6.sp),),
                Text(widget.messagesCubit.allUnverifiedModel.data[widget.index].phone,style: TextStyle(fontSize:6.sp),),
              ],
            ),
            const Spacer(),
            isLoading? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            ): Row(
              children: [
                CustomElevatedButton(title: 'Refuse', onPressed: (){
                  widget.messagesCubit.rejectUser(id: widget.messagesCubit.allUnverifiedModel.data[widget.index].id);
                }, platform: 'tablet', fill: false),
                SizedBox(width: 4.w,),
                CustomElevatedButton(title: 'Approve',
                    platform: 'tablet',
                    onPressed: (){
                      widget.messagesCubit.acceptUser(id: widget.messagesCubit.allUnverifiedModel.data[widget.index].id);
                    }, fill: true),
              ],

            ),
          ],
        ),
      ),
    );
  }
}
