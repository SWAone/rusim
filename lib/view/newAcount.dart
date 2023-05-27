import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/ineed/ineed.dart';
import 'package:rusim/view/Auth/Controller/AuthController.dart';

class newAcuont extends StatelessWidget {
  const newAcuont({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (cc) {
              return Form(
                key: cc.ke2,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          height: 250.h,
                          child: Image.asset('assets/images/icon.jpg')),
                      Center(
                          child: ineed.custmText(
                              data: 'انشاء حساب',
                              color: AppColor.mainColor,
                              fontSize: 20.sp,
                              isbold: true)),
                      Divider(),
                      ineed.custmContainer(
                        havShdow: false,
                        colorr: AppColor.mainColor,
                        w: double.infinity,
                        child: ineed.custemTextForm(
                          lable: 'الاسم',
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
                          lable: ' المعرف',
                          onSaved: (p0) {
                            cc.gamil = p0;
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
                                data: !cc.loding ? 'انشاء' : 'جار التحميل...',
                                color: Colors.white)),
                        onTap: () {
                          print('sssssssssu');
                          cc.CreateAcount();
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
