import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constns/AppColor.dart';
import '../ineed/ineed.dart';
import '../table/Meeting.dart';

class homeC extends GetxController {
  List<Meeting> meetings = <Meeting>[];
  bool loding = true;
  int index = 0;
  int? rank;
  int personIndex = 0;
  List<Map> items = [];
  List<Map> person = [];

  String? uid, name;
  @override
  void onInit() async {
    // getpoints();
    getGroup();
    await FirebaseMessaging.instance.subscribeToTopic('all');

    getMessge();
    uid = await FirebaseAuth.instance.currentUser!.uid;
    getUserInfo();
    super.onInit();
  }

  getUserInfo() async {
    await FirebaseFirestore.instance
        .collection('token')
        .doc(uid)
        .get()
        .then((value) {
      name = value.data()!['name'];
      rank = value.data()!['rank'];
    }).then((value) {
      print('============================ $rank');
    });
  }

  void updeatpoint({required String docid, persoinidd}) async {
    gertPersonPoits(groupId: docid, personDocid: persoinidd);
  }

  void getGroup() async {
    items.clear();
    try {
      await FirebaseFirestore.instance
          .collection('AllGroup')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          items.add({"name": element.data()['GroupName'], "id": element.id});
        });
      }).then((value) {
        update();
        getStaffPersons(gropId: items[0]['id']);
      });
    } catch (e) {}
  }

  void getStaffPersons({required String gropId}) async {
    List<Map> copy = [];

    await FirebaseFirestore.instance
        .collection('AllGroup')
        .doc(gropId)
        .collection('staff')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        copy.add(
          {"name": element.data()['name'], "id": element.id},
        );
      });
    }).then((value) {
      person = copy;

      update();
      Get.back();
    });
  }

  void gertPersonPoits({required String personDocid, groupId}) async {
    meetings.clear();
    await FirebaseFirestore.instance
        .collection('AllGroup')
        .doc(groupId)
        .collection('staff')
        .doc(personDocid)
        .collection('points')
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          Meeting newMeeting = Meeting(
            element.data()['title'],
            element.data()['startTime'].toDate(),
            element.data()['endTime'].toDate(),
            AppColor.mainColor,
            false,
            element.data()['phone'],
          );
          meetings.add(newMeeting);
        });
      },
    ).then((value) async {
      loding = false;
      update();
    });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> sendNotification(
    String title,
    String body,
    String id,
  ) async {
    String serverToken =
        'AAAAAHF5X5M:APA91bFpK2mFros7bXKVBIJGhNSJD-1Hcgqi_7ssVDed0jM7r3HwUMHzzkWVZWUjdTH8EKl9XrBNeJ0b4RSXJOCq_JbvkSoAt9Z7KOeDL-uTuf2LAYnKIGemh9CJbtIoCPcPvYTpK4lq';

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'to': "/topic/all"
          },
          'to': "/topics/all"
        },
      ),
    );
  }

  getMessge() {
    FirebaseMessaging.onMessage.listen((event) {
      Get.snackbar('', '',
          backgroundColor: AppColor.mainColor,
          barBlur: 60,
          messageText: Directionality(
              textDirection: TextDirection.rtl,
              child: ineed.custmText(data: '${event.notification!.body}')),
          titleText: Directionality(
            textDirection: TextDirection.rtl,
            child: ineed.custmText(data: '${event.notification!.title}'),
          ),
          duration: Duration(seconds: 4));
    });
  }
}
