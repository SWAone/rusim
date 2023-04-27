import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constns/AppColor.dart';
import '../table/Meeting.dart';
import '../table/MeetingDataSource.dart';

class homeC extends GetxController {
  List<Meeting> meetings = <Meeting>[];
  bool loding = true;
  int index = 0;
  List<Map> items = [];
  List<Map> person = [];
  @override
  void onInit() async {
    getpoints();
    getGroup();
    super.onInit();

    print(meetings.length);
  }

  void getpoints() async {
    meetings.clear();
    await FirebaseFirestore.instance.collection('points').get().then(
      (value) {
        value.docs.forEach((element) {
          Meeting newMeeting = Meeting(
              element.data()['title'],
              element.data()['startTime'].toDate(),
              element.data()['endTime'].toDate(),
              AppColor.mainColor,
              false);
          meetings.add(newMeeting);
        });
      },
    ).then((value) {
      loding = false;
      update();
    });
  }

  void updeatpoint() async {
    getpoints();
  }

  void getGroup() async {
    items.clear();
    await FirebaseFirestore.instance.collection('AllGroup').get().then((value) {
      value.docs.forEach((element) {
        items.add({"name": element.data()['GroupName'], "id": element.id});
      });
    }).then((value) {
      update();
      getStaffPersons(gropId: items[0]['id']);

      print(items.length);
    });
  }

  void getStaffPersons({required String gropId}) async {
    person.clear();
    await FirebaseFirestore.instance
        .collection('AllGroup')
        .doc(gropId)
        .collection('staff')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        person.add(
          {"name": element.data()['name'], "id": element.id},
        );
      });
    }).then((value) {
      update();
      Get.back();
    });
  }
}
