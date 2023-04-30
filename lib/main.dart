// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:rusim/view/homepage.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       builder: (BuildContext context, Widget? child) {
//         return GetMaterialApp(
//             locale: const Locale('ar', ''),
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//               useMaterial3: true,
//             ),
//             home: homepage());
//       },
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:rusim/constns/AppColor.dart';
import 'package:rusim/view/Auth/login.dart';
import 'package:rusim/view/home.dart';
import 'package:rusim/view/homepage.dart';
import 'package:rusim/view/mainServes.dart';
import 'package:rusim/view/staff.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser == null
              ? login()
              : MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          home(),
          staff(),
          mainServes(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        itemColor: Color.fromARGB(255, 255, 255, 255),
        color: AppColor.mainColor,
        controller: _controller,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home,
              label: 'الرئيسة', activeColor: Colors.white),
          RollingBottomBarItem(Icons.group,
              label: 'المجايع', activeColor: Colors.white),
          RollingBottomBarItem(Icons.shape_line_outlined,
              label: 'الخدمات', activeColor: Colors.white),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
