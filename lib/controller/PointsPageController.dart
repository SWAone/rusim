import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/ineed/ineed.dart';

class pointsPageController extends GetxController {
  String docid, personid;
  homeC homc = Get.put(homeC());
  pointsPageController({required this.personid, required this.docid}) {
    this.docid = docid;
    this.personid = personid;
  }

  List<Map> Pointss = [];
  void getPoints({required String docid, required String persoid}) async {
    await FirebaseFirestore.instance
        .collection('AllGroup')
        .doc(docid)
        .collection('staff')
        .doc(persoid)
        .collection('points')
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          Pointss.add({
            "title": element.data()['title'],
            "startTime": element.data()['startTime'].toDate(),
            "endTime": element.data()['endTime'].toDate(),
            "phone": element.data()['phone'],
            "id": element.id,
          });
        });
      },
    ).then((value) async {
      update();
    });
  }

  @override
  void onInit() {
    getPoints(docid: docid, persoid: personid);
    super.onInit();
  }

  void deletpoints(
      {required String gropid,
      required coustmerName,
      required String persoid,
      required String docid}) async {
    homc.sendNotification(
        " قام  ${homc.name} بحذف  حجز ${homc.person[homc.personIndex]['name']}",
        " اسم الزبون الذي تم حذفه $coustmerName",
        " ");
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
        .collection('AllGroup')
        .doc(gropid)
        .collection('staff')
        .doc(persoid)
        .collection('points')
        .doc(docid)
        .delete()
        .then((value) {
      update();

      Get.back();
      AwesomeDialog(
          body: ineed.custmText(
              data: 'حدث الصفحة لمشاهدة التغيرات', color: Colors.black),
          dialogType: DialogType.success,
          context: Get.context!,
          title: 'تم الحذف',
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'kufi',
            fontWeight: FontWeight.bold,
          )).show();
      getPoints(docid: docid, persoid: personid);
    });
  }

  void UpdatePoint(
      {required newtitle,
      required String newphone,
      required String gropid,
      required String persoid,
      required String docid}) async {
    homc.sendNotification(
        " قام  ${homc.name} يتعديل  حجز ${homc.person[homc.personIndex]['name']}",
        "تعديل حجز",
        " ");
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
        .collection('AllGroup')
        .doc(gropid)
        .collection('staff')
        .doc(persoid)
        .collection('points')
        .doc(docid)
        .update({
      "title": newtitle,
      "phone": newphone,
    }).then((value) {
      update();

      Get.back();
      AwesomeDialog(
          body: ineed.custmText(
              data: 'حدث الصفحة لمشاهدة التغيرات', color: Colors.black),
          dialogType: DialogType.success,
          context: Get.context!,
          title: 'تم التعديل',
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'kufi',
            fontWeight: FontWeight.bold,
          )).show();
      getPoints(docid: docid, persoid: personid);
    });
  }
}
