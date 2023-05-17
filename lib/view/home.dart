import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/main.dart';
import 'package:rusim/view/Auth/login.dart';
import 'package:rusim/view/pointsPage.dart';
import 'package:rusim/view/serves.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../ineed/ineed.dart';
import '../table/Meeting.dart';
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
                                barBlur: 20,
                                messageText: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ineed.custmText(
                                        data: 'في حال لم تظهر حجوزات الكادر')),
                                titleText: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ineed.custmText(
                                      data: 'اضغط على الاسم مرة اخرى'),
                                ),
                                duration: Duration(seconds: 4));
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

                                                                Get.offAll(
                                                                    MyHomePage());
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
                                                  ),
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
                                                    data: cc.person
                                                                .isNotEmpty &&
                                                            cc.items.isNotEmpty
                                                        ? '${cc.person[cc.personIndex]['name']}'
                                                        : 'اختر عضو',
                                                    color: Colors.black),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: AppColor.mainColor,
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            if (cc.person.length > 0) {
                                              Get.defaultDialog(
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'kufi',
                                                  ),
                                                  title: 'كادر العمل',
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
                                                                        Get.offAll(
                                                                            MyHomePage());
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
                                                    ],
                                                  ));
                                            }
                                          }),
                                    ],
                                  ),
                                ));
                          },
                        ),
                        ineed.custmText(
                            data: cc.person.isNotEmpty
                                ? '${cc.person[cc.personIndex]['name']}'
                                : 'جار التحميل ...',
                            color: Colors.black),
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
                    Expanded(
                      child: Container(
                        child: SfCalendar(
                          showWeekNumber: true,
                          allowViewNavigation: true,

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
                                Get.to(() => pontsPage(
                                    name: cc.person[cc.personIndex]['name'],
                                    docid: cc.items[cc.index]['id'],
                                    personId: cc.person[cc.personIndex]['id']));
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
                          showDatePickerButton: true,
                          appointmentBuilder: appointmentBuilder,
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

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final Meeting appointment = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: appointment.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ineed.custmText(
                data: appointment.eventName + ' ' + appointment.phone,
                color: Colors.white),
          ],
        ),
      ),
    );
  }
}
