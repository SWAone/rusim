import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/staffController.dart';
import 'package:rusim/ineed/ineed.dart';
import 'package:rusim/view/stafPerson.dart';

import '../controller/homeC.dart';

class staff extends StatelessWidget {
  homeC homc = Get.put(homeC());

  staff({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GetBuilder<satffController>(
            init: satffController(),
            builder: (cc) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ineed.custmText(
                          data: 'المجاميع والاعضاء',
                          fontSize: 18.sp,
                          isbold: true,
                          color: AppColor.mainColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    homc.rank == 1
                        ? ineed.custmContainer(
                            colorr: Color.fromARGB(255, 49, 171, 169),
                            w: double.infinity,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: ineed.custmText(
                                    data: 'انشاء كادر عمل جديد ',
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    isbold: true),
                              ),
                            ),
                            onTap: () {
                              Get.defaultDialog(
                                  content: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Form(
                                      key: cc.formk,
                                      child: Column(
                                        children: [
                                          ineed.custemTextForm(
                                            lable: 'اسم المجموعه',
                                            onSaved: (p0) {
                                              cc.GroupName = p0;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  textConfirm: 'اضافة',
                                  confirmTextColor: Colors.black,
                                  onConfirm: () {
                                    cc.addGroup();
                                  },
                                  backgroundColor: AppColor.mainColor,
                                  titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'kufi',
                                  ),
                                  title: 'ادخال اسم المجموعه',
                                  buttonColor: Colors.white);
                            },
                          )
                        : Text(''),
                    SizedBox(
                      height: 10.h,
                    ),
                    ineed.custmText(
                        data: 'المجاميع',
                        color: AppColor.mainColor,
                        isbold: true,
                        fontSize: 15.sp),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return cc.AllGroup.length > 0
                              ? InkWell(
                                  onTap: () {
                                    cc.getstaf(
                                        doicId: cc.AllGroup[index]['id']);
                                    Get.to(() => stafPerson(
                                          docid: cc.AllGroup[index]['id'],
                                        ));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        trailing: homc.rank == 1
                                            ? IconButton(
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
                                                        cc.deletGroup(
                                                            GroupNmae: cc
                                                                    .AllGroup[
                                                                index]['id']);
                                                      },
                                                      btnOkText: 'حذف',
                                                      btnCancelText: 'تراجع')
                                                    ..show();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: AppColor.mainColor,
                                                ))
                                            : Text(''),
                                        title: ineed.custmText(
                                            data:
                                                '${cc.AllGroup[index]['name']}',
                                            color: Colors.black,
                                            isbold: true,
                                            fontSize: 17.sp),
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/63441.jpg'),
                                          backgroundColor: AppColor.mainColor,
                                          radius: 25,
                                        ),
                                      )),
                                )
                              : ineed.custmLoding();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount:
                            cc.AllGroup.length > 0 ? cc.AllGroup.length : 10)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
