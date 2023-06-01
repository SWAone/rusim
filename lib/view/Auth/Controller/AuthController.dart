import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/main.dart';

import '../../../ineed/ineed.dart';

class AuthController extends GetxController {
  String? email, pass, personName, gamil;
  bool loding = false;

  GlobalKey<FormState> ke = new GlobalKey<FormState>();
  GlobalKey<FormState> ke2 = new GlobalKey<FormState>();

  void sginIn() async {
    if (ke.currentState!.validate()) {
      ke.currentState!.save();
      loding = true;
      update();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: "$email@gmail.com", password: pass!)
            .then((value) {
          Get.offAll(() => MyHomePage());
        });
      } catch (e) {
        loding = false;
        update();

        Get.snackbar('', '',
            barBlur: 20,
            messageText: Directionality(
                textDirection: TextDirection.rtl,
                child: ineed.custmText(data: e.toString())),
            titleText: Directionality(
              textDirection: TextDirection.rtl,
              child: ineed.custmText(data: 'حدث خطأ'),
            ),
            duration: Duration(seconds: 4));
      }
    }
  }

  void CreateAcount() async {
    if (ke2.currentState!.validate()) {
      loding = true;
      ke2.currentState!.save();
      update();
      try {
        print(gamil);
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: gamil!, password: pass!)
            .then((value) {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          FirebaseMessaging.instance.getToken().then((token) async {
            await FirebaseFirestore.instance.collection('token').doc(uid).set(
                {"name": personName, "token": token, "uid": uid, "rank": -1});
          }).then((value) {
            Get.offAll(MyHomePage());
            loding = false;
            update();
          });
        });
      } catch (e) {
        loding = false;
        update();

        Get.snackbar('', '',
            backgroundColor: AppColor.mainColor,
            barBlur: 20,
            messageText: Directionality(
                textDirection: TextDirection.rtl,
                child: ineed.custmText(data: e.toString())),
            titleText: Directionality(
              textDirection: TextDirection.rtl,
              child: ineed.custmText(data: 'حدث خطأ'),
            ),
            duration: Duration(seconds: 4));
      }
    }
  }
}
