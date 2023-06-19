import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/view/timee.dart';

import '../constns/AppColor.dart';
import '../controller/servesController.dart';
import '../ineed/ineed.dart';

class mainServes extends StatelessWidget {
  mainServes({super.key});
  servesController sc = Get.put(servesController());
  DateTime selectedTime = DateTime.now();
  homeC homc = Get.put(homeC());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: homc.rank == 1
          ? FloatingActionButton(
              onPressed: () {
                Get.to(timee());
              },
              backgroundColor: AppColor.mainColor,
              child: Icon(Icons.add),
            )
          : null,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: GetBuilder<servesController>(
              init: servesController(),
              builder: (cc) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Center(
                          child: ineed.custmText(
                            data: ' الخدمات',
                            color: AppColor.mainColor,
                            isbold: true,
                            fontSize: 20.sp,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_forward_outlined,
                              color: AppColor.mainColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: cc.servesList.length > 0
                                    ? ListTile(
                                        trailing: homc.rank == 1
                                            ? IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  AwesomeDialog(
                                                      buttonsTextStyle:
                                                          TextStyle(
                                                              fontFamily:
                                                                  'kufi',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.sp),
                                                      descTextStyle: TextStyle(
                                                          fontFamily: 'kufi',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.sp),
                                                      context: context,
                                                      dialogType:
                                                          DialogType.info,
                                                      animType:
                                                          AnimType.rightSlide,
                                                      title: 'حذف',
                                                      titleTextStyle: TextStyle(
                                                          fontFamily: 'kufi',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.sp),
                                                      desc: 'سيتم حذف العنصر',
                                                      btnCancelOnPress: () {
                                                        Get.back();
                                                      },
                                                      btnOkOnPress: () {
                                                        cc.deletServes(
                                                            doic: cc.servesList[
                                                                index]['id']);
                                                      },
                                                      btnOkText: 'حذف',
                                                      btnCancelText: 'تراجع')
                                                    ..show();
                                                },
                                                color: AppColor.mainColor,
                                              )
                                            : Text(''),
                                        title: ineed.custmText(
                                            data:
                                                '${cc.servesList[index]['title']}',
                                            color: Colors.black,
                                            isbold: true,
                                            fontSize: 17.sp),
                                        subtitle: ineed.custmText(
                                            data:
                                                '${cc.servesList[index]['time']} دقيقة  ',
                                            color: Colors.black),
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/219430-P0YV0I-878.jpg'),
                                          backgroundColor: AppColor.mainColor,
                                          radius: 25,
                                        ),
                                      )
                                    : ineed.custmLoding()),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: cc.servesList.length > 0
                            ? cc.servesList.length
                            : 10)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
