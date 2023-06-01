import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/PointsPageController.dart';
import 'package:rusim/ineed/ineed.dart';

class edit extends StatelessWidget {
  String title, phone, docid, oersonid, gropid;
  edit({
    super.key,
    required this.title,
    required this.gropid,
    required this.phone,
    required this.docid,
    required this.oersonid,
  });
  pointsPageController cc =
      Get.put(pointsPageController(personid: '', docid: ''));

  TextEditingController textControllerTitle = TextEditingController();
  TextEditingController textControllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: AppColor.mainColor,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(9)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ineed.custemTextForm(
                          //   controllerr:textControllerTitle ,
                          //   color: Colors.black,
                          //   isrequired: false,
                          //   lable: "$title",
                          //   onSaved: (p0) {},
                          // ),
                          TextFormField(
                            onChanged: (value) {
                              title = value;
                              //  textControllerTitle.text = value;
                            },
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'kufi'),
                            onTap: () {
                              textControllerTitle.text = title;
                            },
                            textAlign: TextAlign.right,
                            textDirection: TextDirection
                                .rtl, // تحديد اتجاه النص من اليمين إلى اليسار

                            controller: textControllerTitle,
                            decoration: InputDecoration(
                              hintText: title,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              phone = value;
                              // textControllerPhone.text = value;
                            },
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'kufi'),
                            onTap: () {
                              textControllerPhone.text = phone;
                            },
                            controller: textControllerPhone,
                            decoration: InputDecoration(
                              hintText: phone,
                            ),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),
                          ineed.custmContainer(
                            colorr: AppColor.mainColor,
                            child:
                                Center(child: ineed.custmText(data: 'تعديل')),
                            onTap: () async {
                              cc.UpdatePoint(
                                  newtitle: title,
                                  newphone: phone,
                                  gropid: gropid,
                                  persoid: oersonid,
                                  docid: docid);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
