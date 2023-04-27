import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constns/AppColor.dart';
import '../controller/servesController.dart';
import '../ineed/ineed.dart';

class mainServes extends StatelessWidget {
  mainServes({super.key});
  servesController sc = Get.put(servesController());
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              content: Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: sc.formk,
                  child: Column(
                    children: [
                      ineed.custemTextForm(
                        lable: 'اسم الخدمة ',
                        onSaved: (p0) {
                          sc.title = p0;
                        },
                      ),
                      Divider(),
                      ElevatedButton(
                        onPressed: () async {
                          DatePicker.showTimePicker(
                            context,
                            currentTime: selectedTime,
                            showSecondsColumn:
                                false, // لإظهار أعمدة الثواني في الاختيار ، قم بتعيينها على true
                            onChanged: (DateTime newTime) {
                              print((newTime.hour * 60) + newTime.minute);
                              sc.time = (newTime.hour * 60) + newTime.minute;
                              //  print( newTime.minute) ;
                              // يتم استدعاء هذا الدالة في كل مرة يتم فيها تغيير الوقت المحدد
                              print(
                                  'Selected Time: ${newTime.hour}:${newTime.minute}');
                            },
                            onConfirm: (DateTime finalTime) {
                              sc.time =
                                  (finalTime.hour * 60) + finalTime.minute;
                              // يتم استدعاء هذه الدالة بعد النقر على زر "تأكيد"
                              selectedTime = finalTime;
                            },
                          );
                        },
                        child: Icon(
                          Icons.timer,
                          color: Colors.black,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            backgroundColor: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              textConfirm: 'اضافة',
              confirmTextColor: Colors.black,
              onConfirm: () {
                sc.addServes();
              },
              backgroundColor: AppColor.mainColor,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'kufi',
              ),
              title: 'ادخال معلومات الخدمة',
              buttonColor: Colors.white);
        },
        backgroundColor: AppColor.mainColor,
        child: Icon(Icons.add),
      ),
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
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            AwesomeDialog(
                                                buttonsTextStyle: TextStyle(
                                                    fontFamily: 'kufi',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.sp),
                                                descTextStyle: TextStyle(
                                                    fontFamily: 'kufi',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.sp),
                                                context: context,
                                                dialogType: DialogType.info,
                                                animType: AnimType.rightSlide,
                                                title: 'حذف',
                                                titleTextStyle: TextStyle(
                                                    fontFamily: 'kufi',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.sp),
                                                desc: 'سيتم حذف العنصر',
                                                btnCancelOnPress: () {
                                                  Get.back();
                                                },
                                                btnOkOnPress: () {
                                                  cc.deletServes(
                                                      doic: cc.servesList[index]
                                                          ['id']);
                                                },
                                                btnOkText: 'حذف',
                                                btnCancelText: 'تراجع')
                                              ..show();
                                          },
                                          color: AppColor.mainColor,
                                        ),
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
