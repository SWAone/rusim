import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/controller/PointsPageController.dart';
import 'package:rusim/controller/homeC.dart';
import 'package:rusim/controller/homeController.dart';
import 'package:rusim/view/serves.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../ineed/ineed.dart';
import '../table/MeetingDataSource.dart';

class pontsPage extends StatelessWidget {
  String docid, personId;
  pontsPage({super.key, required this.docid, required this.personId});

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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    ineed.custmText(data: "الحجوزات"),
                    Center(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount:
                            cc.Pointss.length > 0 ? cc.Pointss.length : 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return cc.Pointss.length > 0
                              ? ineed.custmContainer(
                                  colorr: Colors.white,
                                  onTap: () {},
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ineed.custmText(
                                            data:
                                                '${cc.Pointss[index]['title']}',
                                            color: Colors.black),
                                        IconButton(
                                            onPressed: () {
                                              cc.deletpoints(
                                                  docid: cc.Pointss[index]
                                                      ['id'],
                                                  gropid: docid,
                                                  persoid: personId);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                              : ineed.custmLoding();
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
