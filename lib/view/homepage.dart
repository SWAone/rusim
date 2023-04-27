// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:rusim/constns/AppColor.dart';
// import 'package:rusim/controller/homeController.dart';
// import 'package:rusim/view/serves.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import '../ineed/ineed.dart';
// import '../table/MeetingDataSource.dart';

// class homepage extends StatelessWidget {
//   homepage({super.key});
//   DateTime? timeSeceted;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           body: GetBuilder<homeController>(
//             init: homeController(),
//             builder: (cc) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Column(
//                   children: [
//                     Center(
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           hint: cc.loding
//                               ? ineed.custmText(
//                                   data: 'جار التحميل ...', color: Colors.black)
//                               : ineed.custmText(
//                                   data: 'جميع الحجوزات',
//                                   color: AppColor.mainColor,
//                                   isbold: true,
//                                   fontSize: 20.sp),
//                           items: cc.items
//                               .map((item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: AppColor.mainColor,
//                                         ),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: ineed.custmText(
//                                                 data: item,
//                                                 color: AppColor.mainColor,
//                                                 isbold: true),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )))
//                               .toList(),
//                           value: cc.selectedValue,
//                           onChanged: (value) {
//                             cc.update();
//                             cc.selectedValue = value as String;

//                             cc.name = cc.selectedValue;
//                           },
//                           buttonStyleData: const ButtonStyleData(
//                             height: 60,
//                             width: double.infinity,
//                           ),
//                           menuItemStyleData: const MenuItemStyleData(
//                             height: 70,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         child: SfCalendar(
//                           allowViewNavigation:
//                               true, // قم بتفعيل هذا الخيار للسماح بالتكبير والتصغير

//                           onSelectionChanged: (calendarSelectionDetails) {
//                             timeSeceted = DateTime.now();
//                             timeSeceted = calendarSelectionDetails.date;
//                             print(calendarSelectionDetails.date);
//                           },
//                           //في حال تم الضغط على مكان محجوز بوقت
//                           onTap: (CalendarTapDetails details) {
//                             if (details.targetElement ==
//                                 CalendarElement.appointment) {
//                               print('محجوز');
//                             } else {
//                               Get.to(() => serves(
//                                     timeSeceted: timeSeceted,
//                                   ));
//                             }
//                           },
//                           // allowAppointmentResize: true,

//                           view: CalendarView.week,
//                           dataSource:
//                               MeetingDataSource(cc.meetings),
//                           monthViewSettings: const MonthViewSettings(
//                               appointmentDisplayMode:
//                                   MonthAppointmentDisplayMode.appointment),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
