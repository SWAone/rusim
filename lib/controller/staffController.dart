import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rusim/ineed/ineed.dart';

class satffController extends GetxController {
  GlobalKey<FormState> formk = new GlobalKey<FormState>();

  String? GroupName, personName, email, pass;
  DateTime GroupDocNmae = DateTime.now();
  List<Map> AllStaff = [];
  List<Map> AllGroup = [];
  @override
  void onInit() {
    getGroup();
    super.onInit();
  }

  void getstaf({required String doicId}) async {
    AllStaff.clear();
    await FirebaseFirestore.instance
        .collection('AllGroup')
        .doc(doicId)
        .collection('staff')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        AllStaff.add({
          "name": element.data()['name'],
          "id": element.id,
        });
      });
    }).then((value) {
      update();
    });
  }

  void getGroup() async {
    AllGroup.clear();
    await FirebaseFirestore.instance.collection('AllGroup').get().then((value) {
      value.docs.forEach((element) {
        AllGroup.add({
          "name": element.data()['GroupName'],
          "id": element.id,
        });
      });
    }).then((value) {
      update();
      print(AllGroup.length);
    });
  }

  void deletGroup({required String GroupNmae}) async {
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
        .doc(GroupNmae)
        .delete()
        .then((value) {
      Get.back();
      getGroup();
      update();
    });
  }

  void CreateAcount() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "$email@gmail.com", password: pass!)
        .then((value) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      print('ؤقث');
      FirebaseMessaging.instance.getToken().then((token) async {
        await FirebaseFirestore.instance
            .collection('token')
            .doc(uid)
            .set({"name": personName, "token": token, "uid": uid, "rank": 0});
      }).then((value) {
        print('dddddddddddddddddd');
        update();
      });
    });
  }

  void insertStaff({required String doicId}) async {
    var sta = formk.currentState;
    if (sta!.validate()) {
      sta.save();
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
          .doc(doicId)
          .collection('staff')
          .add({
        "name": personName,
      }).then((value) {
        Get.back();
        CreateAcount();
        getstaf(doicId: doicId);
      });
    }
  }

  void deletstaff({required String docid, required String personDocid}) async {
    AwesomeDialog(
        dialogType: DialogType.noHeader,
        context: Get.context!,
        title: 'جار التحميل انتظر قليلا',
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'kufi',
          fontWeight: FontWeight.bold,
        )).show();
    ineed.custmLoding();
    await FirebaseFirestore.instance
        .collection('AllGroup')
        .doc(docid)
        .collection('staff')
        .doc(personDocid)
        .delete()
        .then((value) {
      getstaf(doicId: docid);
      update();

      Get.back();
    });
  }

  void addGroup() async {
    AwesomeDialog(
        dialogType: DialogType.noHeader,
        context: Get.context!,
        title: 'جار التحميل انتظر قليلا',
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'kufi',
          fontWeight: FontWeight.bold,
        )).show();
    var sta = formk.currentState;
    if (sta!.validate()) {
      sta.save();
      await FirebaseFirestore.instance
          .collection('AllGroup')
          .doc(GroupDocNmae.toString())
          .set({"GroupName": GroupName}).then((value) {
        getGroup();
        Get.back();
        update();
      });
    }
  }
}
