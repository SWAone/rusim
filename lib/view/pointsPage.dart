import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/controller/PointsPageController.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/view/edit.dart';

import '../ineed/ineed.dart';

class pontsPage extends StatelessWidget {
  String docid, personId, name;
  TextEditingController textControllerTitle = TextEditingController();
  TextEditingController textControllerPhone = TextEditingController();
  homeC homc = Get.put(homeC());

  pontsPage(
      {super.key,
      required this.docid,
      required this.personId,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: GetBuilder<pointsPageController>(
            init: pointsPageController(docid: docid, personid: personId),
            builder: (cc) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      ineed.custmText(
                          data: "حجوزات $name",
                          color: Colors.black,
                          isbold: true),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Container(
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount:
                                cc.Pointss.length > 0 ? cc.Pointss.length : 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return cc.Pointss.length > 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                          trailing: IconButton(
                                              onPressed: () {
                                                Get.to(() => edit(
                                                      docid: cc.Pointss[index]
                                                          ['id'],
                                                      oersonid: personId,
                                                      gropid: docid,
                                                      phone: cc.Pointss[index]
                                                          ['phone'],
                                                      title: cc.Pointss[index]
                                                          ['title'],
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.red,
                                              )),
                                          leading: IconButton(
                                              onPressed: () {
                                                AwesomeDialog(
                                                  buttonsTextStyle: TextStyle(
                                                      fontFamily: 'kufi',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  btnOkText: 'نعم',
                                                  titleTextStyle: TextStyle(
                                                      fontFamily: 'kufi',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  title: 'حذف ؟',
                                                  context: context,
                                                  btnOkOnPress: () {
                                                    cc.deletpoints(
                                                        coustmerName:
                                                            cc.Pointss[index]
                                                                ['title'],
                                                        docid: cc.Pointss[index]
                                                            ['id'],
                                                        gropid: docid,
                                                        persoid: personId);
                                                  },
                                                ).show();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                          title: ineed.custmText(
                                              data:
                                                  '${cc.Pointss[index]['title']}',
                                              color: Colors.black,
                                              isbold: true),
                                          subtitle: ineed.custmText(
                                            data:
                                                '${cc.Pointss[index]['phone']}',
                                            color: Colors.black,
                                          )),
                                    )
                                  : ineed.custmLoding();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
