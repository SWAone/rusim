import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/controller/homeController.dart';
import 'package:rusim/view/Auth/login.dart';
import 'package:rusim/view/pointsPage.dart';
import 'package:rusim/view/serves.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../ineed/ineed.dart';
import '../table/MeetingDataSource.dart';

class home extends StatelessWidget {
  home({super.key});
  DateTime? timeSeceted;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: GetBuilder<homeC>(
            init: homeC(),
            builder: (cc) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ineed.custmContainer(
                          h: 30.h,
                          havShdow: false,
                          colorr: AppColor.mainColor,
                          child: Center(
                              child: ineed.custmText(data: 'اختر المجموعة')),
                          onTap: () {
                            Get.snackbar('', '',
                                duration: Duration(minutes: 20));
                            Get.defaultDialog(
                                title: "حدد المجموعة والعضو",
                                titleStyle: TextStyle(
                                    fontFamily: 'kufi', color: Colors.white),
                                backgroundColor: AppColor.mainColor,
                                content: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      ineed.custmContainer(
                                        colorr: Colors.white,
                                        w: 100.w,
                                        h: 30.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ineed.custmText(
                                                data: cc.items.length > 0
                                                    ? '${cc.items[cc.index]['name']}'
                                                    : 'اختر مجموعة',
                                                color: Colors.black),
                                            Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: AppColor.mainColor,
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          cc.person.length > 0 &&
                                                  cc.items.length > 0
                                              ? cc.gertPersonPoits(
                                                  personDocid:
                                                      cc.person[cc.personIndex]
                                                          ['id'],
                                                  groupId: cc.items[cc.index]
                                                      ['id'])
                                              : null;
                                          Get.defaultDialog(
                                              titleStyle: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'kufi',
                                              ),
                                              title: 'المجاميع',
                                              backgroundColor:
                                                  AppColor.mainColor,
                                              content: Column(
                                                children: [
                                                  Container(
                                                    height: 300.h,
                                                    width: 200.w,
                                                    child: ListView.separated(
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return Divider();
                                                      },
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          cc.items.length > 0
                                                              ? cc.items.length
                                                              : 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Directionality(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          child: ineed
                                                              .custmContainer(
                                                            colorr:
                                                                Colors.white,
                                                            w: double.infinity,
                                                            onTap: () {
                                                              if (cc.items
                                                                      .length >
                                                                  0) {
                                                                cc.index =
                                                                    index;

                                                                cc.getStaffPersons(
                                                                    gropId: cc.items[
                                                                            index]
                                                                        ['id']);
                                                                cc.gertPersonPoits(
                                                                    personDocid:
                                                                        cc.person[0]
                                                                            [
                                                                            'id'],
                                                                    groupId: cc
                                                                            .items[index]
                                                                        ['id']);

                                                                Get.back();
                                                              }
                                                            },
                                                            child: Center(
                                                              child: ineed.custmText(
                                                                  data: cc.items
                                                                              .length >
                                                                          0
                                                                      ? '${cc.items[index]['name']}'
                                                                      : 'لا يوجد مجاميع',
                                                                  color: Colors
                                                                      .black,
                                                                  isbold: true),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                      Divider(),
                                      ineed.custmContainer(
                                          colorr: Colors.white,
                                          w: 100.w,
                                          h: 30.h,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 90.w,
                                                child: ineed.custmText(
                                                    data: cc.person.length >
                                                                0 &&
                                                            cc.items.length > 0
                                                        ? '${cc.person[cc.personIndex]['name']}'
                                                        : 'اختر عضو',
                                                    color: Colors.black),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: AppColor.mainColor,
                                              )
                                            ],
                                          ),
                                          onTap: () {
                                            if (cc.person.length > 0) {
                                              Get.defaultDialog(
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'kufi',
                                                  ),
                                                  title: 'اعضاء المجموعة',
                                                  backgroundColor:
                                                      AppColor.mainColor,
                                                  content: Column(
                                                    children: [
                                                      Container(
                                                        height: 300.h,
                                                        width: 200.w,
                                                        child:
                                                            ListView.separated(
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return Divider();
                                                          },
                                                          shrinkWrap: true,
                                                          itemCount: cc.person
                                                                      .length >
                                                                  0
                                                              ? cc.person.length
                                                              : 5,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return cc.items
                                                                        .length >
                                                                    0
                                                                ? Directionality(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    child: ineed
                                                                        .custmContainer(
                                                                      colorr: Colors
                                                                          .white,
                                                                      w: double
                                                                          .infinity,
                                                                      onTap:
                                                                          () {
                                                                        cc.personIndex =
                                                                            index;
                                                                        cc.gertPersonPoits(
                                                                            personDocid:
                                                                                cc.person[index]['id'],
                                                                            groupId: cc.items[cc.index]['id']);
                                                                        Get.back();
                                                                        ///////
                                                                        ///
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child: ineed.custmText(
                                                                            data:
                                                                                '${cc.person[index]['name']}',
                                                                            color:
                                                                                Colors.black,
                                                                            isbold: true),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : ineed.custmText(
                                                                    data:
                                                                        'جار التحميل ..');
                                                          },
                                                        ),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.to(() => pontsPage(
                                                                docid: cc.items[
                                                                        cc.index]
                                                                    ['id'],
                                                                personId:
                                                                    cc.person[cc
                                                                            .personIndex]
                                                                        [
                                                                        'id']));
                                                          },
                                                          child: ineed.custmText(
                                                              data:
                                                                  'ادارة حجوزات العضو المحدد',
                                                              color:
                                                                  Colors.white))
                                                    ],
                                                  ));
                                            }
                                          }),
                                    ],
                                  ),
                                ));
                          },
                        ),
                        IconButton(
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
                                  title: 'تسجل الخروج',
                                  titleTextStyle: TextStyle(
                                      fontFamily: 'kufi',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                  btnCancelOnPress: () {
                                    Get.back();
                                  },
                                  btnOkOnPress: () {
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((value) {
                                      Get.offAll(login());
                                    });
                                  },
                                  btnOkText: 'نعم',
                                  btnCancelText: 'تراجع')
                                ..show();
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                              color: AppColor.mainColor,
                            )),
                      ],
                    ),

                    // Center(
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton2(
                    //       hint: cc.loding
                    //           ? ineed.custmText(
                    //               data: 'جار التحميل ...', color: Colors.black)
                    //           : ineed.custmText(
                    //               data: cc.items[0],
                    //               color: AppColor.mainColor,
                    //               isbold: true,
                    //               fontSize: 20.sp),
                    //       items: cc.items
                    //           .map((item) => DropdownMenuItem<String>(
                    //               value: item,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                       color: AppColor.mainColor,
                    //                     ),
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: ineed.custmText(
                    //                             data: item,
                    //                             color: AppColor.mainColor,
                    //                             isbold: true),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               )))
                    //           .toList(),
                    //       value: cc.selectedValue,
                    //       onChanged: (value) {
                    //         print(value);
                    //         cc.update();
                    //         cc.selectedValue = value as String;

                    //         cc.name = cc.selectedValue!;
                    //       },
                    //       buttonStyleData: const ButtonStyleData(
                    //         height: 60,
                    //         width: double.infinity,
                    //       ),
                    //       menuItemStyleData: const MenuItemStyleData(
                    //         height: 70,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton2(
                    //     hint: cc.loding
                    //         ? ineed.custmText(
                    //             data: 'جار التحميل ...', color: Colors.black)
                    //         : ineed.custmText(
                    //             data: cc.items[0],
                    //             color: AppColor.mainColor,
                    //             isbold: true,
                    //             fontSize: 20.sp),
                    //     items: cc.items
                    //         .map((item) => DropdownMenuItem<String>(
                    //             value: item,
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Container(
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                     color: AppColor.mainColor,
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceEvenly,
                    //                   children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.all(8.0),
                    //                       child: ineed.custmText(
                    //                           data: item,
                    //                           color: AppColor.mainColor,
                    //                           isbold: true),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             )))
                    //         .toList(),
                    //     value: cc.selectedValue,
                    //     onChanged: (value) {
                    //       cc.update();
                    //       cc.selectedValue = value as String;

                    //       cc.name = cc.selectedValue!;
                    //     },
                    //     buttonStyleData: const ButtonStyleData(
                    //       height: 60,
                    //       width: double.infinity,
                    //     ),
                    //     menuItemStyleData: const MenuItemStyleData(
                    //       height: 70,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        child: SfCalendar(
                          allowViewNavigation:
                              true, // قم بتفعيل هذا الخيار للسماح بالتكبير والتصغير

                          onSelectionChanged: (calendarSelectionDetails) {
                            timeSeceted = DateTime.now();
                            timeSeceted = calendarSelectionDetails.date;
                            print(calendarSelectionDetails.date);
                          },
                          //في حال تم الضغط على مكان محجوز بوقت
                          onTap: (CalendarTapDetails details) {
                            try {
                              if (details.targetElement ==
                                  CalendarElement.appointment) {
                                print(details.date);
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'حذف',
                                  desc: 'هل تريد حذف هذا الحجز',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                                print('محجوز');
                              } else {
                                if (cc.person.length > 0) {
                                  Get.to(() => serves(
                                        StaffName: cc.person[cc.personIndex]
                                            ['name'],
                                        docid: cc.items[cc.index]['id'],
                                        personId: cc.person[cc.personIndex]
                                            ['id'],
                                        timeSeceted: timeSeceted,
                                      ));
                                } else {
                                  Get.snackbar('انتبه', 'اختر عضو');
                                }
                              }
                            } catch (e) {}
                          },
                          // allowAppointmentResize: true,

                          view: CalendarView.week,
                          dataSource: MeetingDataSource(cc.meetings),
                          monthViewSettings: const MonthViewSettings(
                              appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.appointment),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
