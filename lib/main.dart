import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:skate_spot_finder/services/firebase_services.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/detailed_spot/dietailed_spot.dart';
import 'package:skate_spot_finder/views/findSpot/find_spot.dart';
import 'package:skate_spot_finder/views/google_map/google_map.dart';
import 'package:skate_spot_finder/views/gpsPage/gps_page.dart';
import 'package:skate_spot_finder/views/gpsPage/manual_GPS.dart';
import 'package:skate_spot_finder/views/mainPage/main_page.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import 'package:skate_spot_finder/views/newSpot/new_spot.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skate_spot_finder/views/photoPage/photo_page.dart';
import 'package:skate_spot_finder/views/start_page/start_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init('riderSwitch');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_){
  runApp(MyApp());
});
      }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseServices().setSwitch();
    DetailedPageController detailedPageController = Get.put(DetailedPageController());

    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'londrina', appBarTheme: AppBarTheme(backgroundColor: Colors.black)),
      // theme: ThemeData(brightness: Brightness.dark, fontFamily: 'londrina', scaffoldBackgroundColor: Color(0xff565656)),
      // theme: ThemeData(scaffoldBackgroundColor: Color(0xFFe98d20),
      //     fontFamily: 'londrina',
      //     appBarTheme: AppBarTheme(color: Color(0xFF232f34))),
      getPages: [
        GetPage(name: '/', page: () => MainPage(), transition: Transition.leftToRight),
        GetPage(name: '/newSpot', page: () => NewSpot(), transition: Transition.rightToLeft),
        GetPage(name: '/manualGPS', page: () => ManualGPS(), transition: Transition.rightToLeft),
        GetPage(name: '/findSpot', page: () => FindSpot()),
        GetPage(name: '/photoPage', page: () => PhotoPage()),
        GetPage(name: '/gpsPage', page: () => GpsPage()),
        GetPage(name: '/detailPage', page: () => DetailedSpot()),
        GetPage(name: '/googleMap', page:()=>GoogleMapPage()),
        GetPage(name: '/startPage', page:()=>StartPage()),
      ],
    );
  }
}
