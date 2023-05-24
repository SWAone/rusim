import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../constns/AppColor.dart';

class ineed {
  static Widget custmText({
    required String data,
    double? fontSize,
    Color color = Colors.white,
    String fontFamily = 'kufi',
    bool isbold = false,
  }) {
    {
      return Text(
        data,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontFamily: fontFamily,
            fontWeight: isbold ? FontWeight.bold : FontWeight.normal),
      );
    }
  }

  static Widget allusionsContainer(
      {required String title, required String body, bool withoutBody = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: AppColor.mainColor),
        child: !withoutBody
            ? Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: ineed.custmText(
                          data: title, fontSize: 16.sp, isbold: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 15, right: 15, top: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColor.mainColor),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: ineed.custmText(
                              data: body,
                              fontSize: 17.sp,
                              isbold: true,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Center(
                  child: ineed.custmText(
                      data: title, fontSize: 16.sp, isbold: true),
                ),
              ),
      ),
    );
  }

  static Widget custmContainer(
      {required Widget child,
      bool havShdow = true,
      required void Function() onTap,
      Color? colorr,
      double w = 100,
      double h = 50,
      int radius = 10}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: w.w,
        height: h.h,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: havShdow ? 4 : 0,
            blurRadius: havShdow ? 5 : 0,
            offset: const Offset(0, 3),
          ),
        ], borderRadius: BorderRadius.circular(10), color: colorr),
        child: child,
      ),
    );
  }

  static Widget custemTextForm(
      {required String lable,
      Color color = Colors.white,
      TextEditingController? controllerr,
      required void Function(String?)? onSaved,
      bool isrequired = true}) {
    return TextFormField(
      controller: controllerr,
      onSaved: onSaved,
      validator: isrequired
          ? (value) {
              if (value!.isEmpty) {
                return "هذا الحقل مطلوب";
              }
            }
          : null,
      style: TextStyle(
          color: color, fontWeight: FontWeight.bold, fontFamily: 'kufi'),
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              ineed.custmText(data: lable, fontSize: 15.sp, color: color),
              SizedBox(
                width: 5.w,
              ),
              isrequired
                  ? ineed.custmText(
                      data: '*', fontSize: 20.sp, color: Colors.red)
                  : Text('')
            ],
          ),
        ),
      ),
    );
  }

  static Widget custmLoding() {
    return Container(
        height: 60.h,
        child: Shimmer.fromColors(
            child: ineed.custmContainer(
              child: ListTile(
                title: Container(
                  width: 50.w,
                  height: 10.h,
                  color: Colors.black,
                ),
                leading: CircleAvatar(
                  radius: 20.sp,
                ),
                trailing: Icon(Icons.edit),
              ),
              onTap: () {},
            ),
            baseColor: Color.fromARGB(255, 160, 175, 131),
            highlightColor: AppColor.mainColor));
  }

  static AwesomeDialog lodingDuilog(
      {String title = '....جار التحميل انتظر قليلا'}) {
    return AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: Get.context!,
        dialogType: DialogType.noHeader,
        title: title,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'kufi',
          fontWeight: FontWeight.bold,
        ));
  }

  static AwesomeDialog CustmAwsmDilog(
      {DialogType dialogType = DialogType.info,
      String? title = 'title',
      void Function()? btnOkOnPress,
      void Function()? btnCancelOnPress,
      String btnOkText = 'اوكي',
      String btnCancelText = 'تراجع',
      String? desc = 'الوصف'}) {
    return AwesomeDialog(
        buttonsTextStyle: TextStyle(
            fontFamily: 'kufi', fontWeight: FontWeight.bold, fontSize: 20.sp),
        descTextStyle: TextStyle(
            fontFamily: 'kufi', fontWeight: FontWeight.bold, fontSize: 20.sp),
        context: Get.context!,
        dialogType: dialogType,
        animType: AnimType.rightSlide,
        title: title,
        titleTextStyle: TextStyle(
            fontFamily: 'kufi', fontWeight: FontWeight.bold, fontSize: 20.sp),
        desc: desc,
        btnCancelOnPress: btnCancelOnPress,
        btnOkOnPress: btnOkOnPress,
        btnOkText: btnOkText,
        btnCancelText: btnCancelText);
  }

  static snackBar({String title = 'العنوان', String dec = 'الوصف'}) {
    return Get.snackbar('', '',
        barBlur: 20,
        messageText: Directionality(
            textDirection: TextDirection.rtl,
            child: ineed.custmText(data: dec)),
        titleText: Directionality(
          textDirection: TextDirection.rtl,
          child: ineed.custmText(data: title),
        ),
        duration: Duration(seconds: 4));
  }

  static getMessge() {
    FirebaseMessaging.onMessage.listen((event) {
      Get.snackbar('', '',
          backgroundColor: AppColor.mainColor,
          barBlur: 60,
          messageText: Directionality(
              textDirection: TextDirection.rtl,
              child: ineed.custmText(data: '${event.notification!.body}')),
          titleText: Directionality(
            textDirection: TextDirection.rtl,
            child: ineed.custmText(data: '${event.notification!.title}'),
          ),
          duration: Duration(seconds: 5));
    });
  }
}
