import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/servesController.dart';
import 'package:rusim/ineed/ineed.dart';

class timee extends StatelessWidget {
  const timee({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<servesController>(
          init: servesController(),
          builder: (sc) {
            return Form(
              key: sc.formk,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Divider(
                        color: Colors.white,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: ineed.custemTextForm(
                            color: Colors.black,
                            lable: 'اسم الخدمة ',
                            onSaved: (p0) {
                              sc.title = p0;
                            },
                          ),
                        ),
                      ),
                      // Center(
                      //   child: DurationPicker(
                      //     duration: sc.timepic,
                      //     onChange: (val) {
                      //       sc.time = val.inMinutes;
                      //       print(val.inMinutes);
                      //       sc.UpdateTimePic(val);
                      //     },
                      //     snapToMins: 5.0,
                      //   ),
                      // ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: ineed.custemTextForm(
                            isnumbe: true,
                            color: Colors.black,
                            lable: 'عدد الدقائق',
                            onSaved: (p0) {
                              sc.time = int.parse('$p0');
                              ;
                            },
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {
                                sc.addServes();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ineed.custmText(
                                    data: 'اضافة', isbold: true),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
