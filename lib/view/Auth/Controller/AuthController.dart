import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rusim/main.dart';

class AuthController extends GetxController {
  String? name, email, pass, uid;
  bool loding = false;

  GlobalKey<FormState> ke = new GlobalKey<FormState>();
  void CreateAcount() async {
    if (ke.currentState!.validate()) {
      ke.currentState!.save();
      loding = true;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "$email@gmail.com", password: pass!)
          .then((value) {
        uid = FirebaseAuth.instance.currentUser!.uid;
        print('ؤقث');
        FirebaseMessaging.instance.getToken().then((token) async {
          loding = true;
          Get.offAll(() => MyHomePage());
          await FirebaseFirestore.instance
              .collection('token')
              .doc(uid)
              .set({"name": name, "token": token, "uid": uid, "rank": 0});
        }).then((value) {
          print('dddddddddddddddddd');
          update();
        });
      });
    }
  }
}
