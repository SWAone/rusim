import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/controller/homeController.dart';
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ineed.custmContainer(
                          colorr: Colors.white,
                          w: 100.w,
                          h: 30.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            Get.defaultDialog(
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'kufi',
                                ),
                                title: 'المجاميع',
                                backgroundColor: AppColor.mainColor,
                                content: Column(
                                  children: [
                                    Container(
                                      height: 300.h,
                                      width: 200.w,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                        shrinkWrap: true,
                                        itemCount: cc.items.length > 0
                                            ? cc.items.length
                                            : 5,
                                        itemBuilder: (context, index) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: ineed.custmContainer(
                                              colorr: Colors.white,
                                              w: double.infinity,
                                              onTap: () {
                                                cc.index = index;
                                                print(cc.items[index]['id']);
                                                cc.getStaffPersons(
                                                    gropId: cc.items[index]
                                                        ['id']);
                                              },
                                              child: Center(
                                                child: ineed.custmText(
                                                    data:
                                                        '${cc.items[index]['name']}',
                                                    color: Colors.black,
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
                        ineed.custmContainer(
                            colorr: Colors.white,
                            w: 100.w,
                            h: 30.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ineed.custmText(
                                    data: cc.person.length > 0
                                        ? '${cc.person[0]['name']}'
                                        : 'اختر عضو',
                                    color: Colors.black),
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
                                    backgroundColor: AppColor.mainColor,
                                    content: Column(
                                      children: [
                                        Container(
                                          height: 300.h,
                                          width: 200.w,
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            shrinkWrap: true,
                                            itemCount: cc.person.length > 0
                                                ? cc.person.length
                                                : 5,
                                            itemBuilder: (context, index) {
                                              return cc.items.length > 0
                                                  ? Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child:
                                                          ineed.custmContainer(
                                                        colorr: Colors.white,
                                                        w: double.infinity,
                                                        onTap: () {
                                                          // cc.index = index;
                                                          // print(cc.items[index]['id']);
                                                          // cc.getStaffPersons(
                                                          //     gropId: cc.person[index]
                                                          //         ['id']);
                                                        },
                                                        child: Center(
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
                                                      data: 'جار التحميل ..');
                                            },
                                          ),
                                        )
                                      ],
                                    ));
                              }
                            })
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
                            if (details.targetElement ==
                                CalendarElement.appointment) {
                              print('محجوز');
                            } else {
                              Get.to(() => serves(
                                    timeSeceted: timeSeceted,
                                  ));
                            }
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
