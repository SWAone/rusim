import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rusim/main.dart';

import '../../../ineed/ineed.dart';

class AuthController extends GetxController {
  String? email, pass;
  bool loding = false;

  GlobalKey<FormState> ke = new GlobalKey<FormState>();
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
}
