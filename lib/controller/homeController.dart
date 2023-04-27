// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:rusim/table/Meeting.dart';

// import '../constns/AppColor.dart';
// import '../table/MeetingDataSource.dart';

// class homeController extends GetxController {
//   bool loding = false;

//   @override
//   void onInit() async {
//     onInit();

//     loding = true;

//     MeetingDataSource.meetings.clear();
//     await FirebaseFirestore.instance.collection('points').get().then(
//       (value) {
//         value.docs.forEach((element) {
//           Meeting newMeeting = Meeting(
//               element.data()['title'],
//               element.data()['startTime'].toDate(),
//               element.data()['endTime'].toDate(),
//               AppColor.mainColor,
//               false);
//           MeetingDataSource.meetings.add(newMeeting);
//         });
//       },
//     ).then((value) {
//       loding = false;
//       update();
//     });

//     super.onInit();
//   }

  // void getGroup() async {
  //   AllGroup.clear();
  //   await FirebaseFirestore.instance.collection('AllGroup').get().then((value) {
  //     value.docs.forEach((element) {
  //       AllGroup.add({
  //         "name": element.data()['GroupName'],
  //         "id": element.id,
  //       });
  //     });
  //   }).then((value) {
  //     update();
  //     print(AllGroup.length);
  //   });
  // }

//   void updatee() {
//     onInit();
//   }

//   final List<String> items = [
//     'لمياء',
//     'زهراء',
//     'اسماء',
//     'بهاء',
//     'علاء',
//     'صفاء',
//     'ولاء',
//     'نجلاء',
//   ];
//   String? selectedValue, name;
// }
