import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/ineed/ineed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rusim/view/Auth/Controller/AuthController.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(31, 243, 243, 243),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (cc) {
              return Form(
                key: cc.ke,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: ineed.custmText(
                            data: 'تسجيل الدخول',
                            color: AppColor.mainColor,
                            fontSize: 20.sp,
                            isbold: true)),
                    Divider(),
                    ineed.custmContainer(
                      havShdow: false,
                      colorr: AppColor.mainColor,
                      w: double.infinity,
                      child: ineed.custemTextForm(
                        lable: 'المعرف',
                        onSaved: (p0) {
                          cc.email = p0;
                        },
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    ineed.custmContainer(
                      havShdow: false,
                      colorr: AppColor.mainColor,
                      w: double.infinity,
                      child: ineed.custemTextForm(
                        lable: 'كلمة السر',
                        onSaved: (p0) {
                          cc.pass = p0;
                        },
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    ineed.custmContainer(
                      havShdow: false,
                      colorr: AppColor.mainColor,
                      child: Center(
                          child: ineed.custmText(
                              data: !cc.loding
                                  ? 'تسجيل الدخول'
                                  : 'جار التحميل...',
                              color: Colors.white)),
                      onTap: () {
                        cc.sginIn();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
