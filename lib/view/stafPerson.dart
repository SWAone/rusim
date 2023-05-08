import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/staffController.dart';
import 'package:rusim/ineed/ineed.dart';

import '../controller/homeC.dart';

class stafPerson extends StatelessWidget {
  String docid;
  stafPerson({super.key, required this.docid});
  homeC homc = Get.put(homeC());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<satffController>(
      init: satffController(),
      builder: (cc) {
        return Scaffold(
          floatingActionButton: homc.rank == 1
              ? FloatingActionButton(
                  onPressed: () {
                    Get.defaultDialog(
                        content: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Form(
                            key: cc.formk,
                            child: Column(
                              children: [
                                ineed.custemTextForm(
                                  lable: 'الاسم',
                                  onSaved: (p0) {
                                    cc.personName = p0;
                                  },
                                ),
                                Divider(),
                                ineed.custemTextForm(
                                  lable: 'انشاء معرف',
                                  onSaved: (p0) {
                                    cc.email = p0;
                                  },
                                ),
                                Divider(),
                                ineed.custemTextForm(
                                  lable: 'كلمة سر',
                                  onSaved: (p0) {
                                    cc.pass = p0;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        textConfirm: 'اضافة',
                        confirmTextColor: Colors.black,
                        onConfirm: () {
                          cc.insertStaff(doicId: docid);
                        },
                        backgroundColor: AppColor.mainColor,
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'kufi',
                        ),
                        title: 'اضافة عضو جديد',
                        buttonColor: Colors.white);
                  },
                  backgroundColor: AppColor.mainColor,
                  child: Icon(Icons.add),
                )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GetBuilder<satffController>(
                init: satffController(),
                builder: (cc) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            ineed.custmText(
                              data: 'اعضاء الفريق',
                              fontSize: 18.sp,
                              isbold: true,
                              color: AppColor.mainColor,
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: AppColor.mainColor,
                                  size: 22.sp,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return cc.AllStaff.length > 0
                                  ? InkWell(
                                      onTap: () {},
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
                                                                  fontSize: 20
                                                                      .sp),
                                                          descTextStyle:
                                                              TextStyle(
                                                                  fontFamily:
                                                                      'kufi',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.sp),
                                                          context: context,
                                                          dialogType:
                                                              DialogType.info,
                                                          animType: AnimType
                                                              .rightSlide,
                                                          title: 'حذف',
                                                          titleTextStyle: TextStyle(
                                                              fontFamily:
                                                                  'kufi',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.sp),
                                                          desc:
                                                              'سيتم حذف العنصر',
                                                          btnCancelOnPress: () {
                                                            Get.back();
                                                          },
                                                          btnOkOnPress: () {
                                                            cc.deletstaff(
                                                              docid: docid,
                                                              personDocid: cc
                                                                      .AllStaff[
                                                                  index]['id'],
                                                            );
                                                          },
                                                          btnOkText: 'حذف',
                                                          btnCancelText:
                                                              'تراجع')
                                                        ..show();
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: AppColor.mainColor,
                                                    ))
                                                : Text(''),
                                            title: ineed.custmText(
                                                data:
                                                    '${cc.AllStaff[index]['name']}',
                                                color: Colors.black,
                                                isbold: true,
                                                fontSize: 17.sp),
                                            leading: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/ml.jpg'),
                                              backgroundColor:
                                                  AppColor.mainColor,
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
                            itemCount: cc.AllStaff.length > 0
                                ? cc.AllStaff.length
                                : 10)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    ));
  }
}
