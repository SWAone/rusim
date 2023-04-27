import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/controller/homeController.dart';
import 'package:rusim/controller/servesController.dart';
import 'package:rusim/ineed/ineed.dart';
import 'package:rusim/table/MeetingDataSource.dart';
import 'package:rusim/view/homepage.dart';
import 'package:shimmer/shimmer.dart';

import '../constns/AppColor.dart';
import '../table/Meeting.dart';

class serves extends StatelessWidget {
  DateTime? timeSeceted;
  serves({super.key, required this.timeSeceted});
  homeC homController = Get.put(homeC());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                            data: 'تعين الخدمات',
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
                            onTap: () {
                              Get.defaultDialog(
                                  content: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Form(
                                      key: cc.formk2,
                                      child: Column(
                                        children: [
                                          ineed.custemTextForm(
                                            lable: 'اسم الزبون',
                                            onSaved: (p0) {
                                              cc.title = p0;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  textConfirm: 'اضافة',
                                  confirmTextColor: Colors.black,
                                  onConfirm: () {
                                    cc.setPoint(
                                        timeSeceted: timeSeceted!,
                                        endTimee: cc.servesList[index]['time']);
                                    homController.updeatpoint();
                                  },
                                  backgroundColor: AppColor.mainColor,
                                  titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'kufi',
                                  ),
                                  title: 'ادخال معلومات الزبون',
                                  buttonColor: Colors.white);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: cc.servesList.length > 0
                                    ? ListTile(
                                        trailing: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: AppColor.mainColor,
                                            )),
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
