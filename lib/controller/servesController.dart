import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/ineed/ineed.dart';

import '../constns/AppColor.dart';
import '../table/Meeting.dart';
import '../table/MeetingDataSource.dart';

class servesController extends GetxController {
  List<Map> servesList = [];
  bool getServesLoding = true;
  homeC homc = Get.put(homeC());

  GlobalKey<FormState> formk = new GlobalKey<FormState>();
  GlobalKey<FormState> formk2 = new GlobalKey<FormState>();

  String? title;
  int? time;

  showServes() async {
    getServesLoding = true;
    servesList.clear();
    await FirebaseFirestore.instance.collection('serves').get().then((value) {
      value.docs.forEach((element) {
        servesList.add({
          "id": element.id,
          "title": element.data()['title'],
          "time": element.data()['time'],
        });
      });
    }).then((value) {
      print(servesList);
      getServesLoding = false;
      update();
    }).then((value) {
      update();
    });
  }

  addServes() async {
    var sta = formk.currentState;
    if (sta!.validate()) {
      AwesomeDialog(
          dialogType: DialogType.noHeader,
          context: Get.context!,
          title: 'جار التحميل انتظر قليلا',
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'kufi',
            fontWeight: FontWeight.bold,
          )).show();
      sta.save();
      getServesLoding = true;

      await FirebaseFirestore.instance.collection('serves').add({
        "title": title,
        "time": time == null ? 30 : time,
      }).then((value) {
        onInit();
        update();

        Get.back();
      });
    }
  }

  setPoint(
      {required DateTime timeSeceted,
      required int endTimee,
      required String groupId,
      required String servesName,
      required String staffName,
      PresonId}) async {
    var sta = formk2.currentState;
    if (sta!.validate()) {
      sta.save();

      DateTime startTime = DateTime(timeSeceted.year, timeSeceted.month,
          timeSeceted.day, timeSeceted.hour);
      DateTime endTime = startTime.add(Duration(minutes: endTimee));
      homc.sendNotification(
          " قام  ${homc.name}باضافة حجز جديد  $servesName لقائمة  $staffName",
          "من الساعة ${timeSeceted.hour} : ${timeSeceted.minute} لتاريخ ${timeSeceted.year}/${timeSeceted.month}/${timeSeceted.day} مدة الحجز ${timeSeceted.hour + endTimee} دقيقة",
          " ");
      await FirebaseFirestore.instance
          .collection('AllGroup')
          .doc(groupId)
          .collection('staff')
          .doc(PresonId)
          .collection('points')
          .add({
        "title": title,
        "startTime": startTime,
        "endTime": endTime
      }).then((value) {
        update();
      });

      Get.back();
    }
  }

  void deletServes({required String doic}) async {
    AwesomeDialog(
        dialogType: DialogType.noHeader,
        context: Get.context!,
        title: 'جار التحميل انتظر قليلا',
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'kufi',
          fontWeight: FontWeight.bold,
        )).show();
    await FirebaseFirestore.instance
        .collection('serves')
        .doc(doic)
        .delete()
        .then((value) {
      Get.back();
      showServes();
      update();
    });
  }

  @override
  void onInit() {
    showServes();
    super.onInit();
  }
}
