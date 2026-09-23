import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/splash_screen/splash_screen.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'firebase/get_fcm_token.dart';
import 'services/init.dart';

import 'firebase_options_primary.dart' as primary_env;

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init().initialize();
  await Firebase.initializeApp(
    name:
        'primaryApp', // Optional: use a name if initializing multiple simultaneously
    options: primary_env.PrimaryFirebaseOptions.currentPlatform,
  );

  await NotificationServices.initialize();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  initPlatForm() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.none);

    OneSignal.initialize('appId'); //---------------------ADD ONESIGNAL APP ID
    OneSignal.User.pushSubscription.optIn();
    await OneSignal.consentRequired(true);

    await NotificationServices().init();

    OneSignal.Notifications.addForegroundWillDisplayListener(
        (OSNotificationWillDisplayEvent event) {
      /// preventDefault to not display the notification
      event.preventDefault();

      /// Do async work
      /// notification.display() to display after preventing default
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((OSNotificationClickEvent result) {
      ///TODO:
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('Current state = $state');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatForm();
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ScreenUtilInit(
        designSize: Size(432.0, 960.0),

        minTextAdapt: true,
        // splitScreenMode: true,
        child: GetMaterialApp(
          title: AppConstants.appName,
          navigatorKey: navigatorKey,
          themeMode: ThemeMode.light,
          theme: CustomTheme.light,
          debugShowCheckedModeBanner: false,
          // home: const SplashScreen(),
          home: const InvestmentApp(),
        ),
      ),
    );
  }
}



// | Property              | Use         |
// | --------------------- | ----------- |
// | Width                 | `100.w`     |
// | Height                | `50.h`      |
// | Font Size             | `14.sp`     |
// | Border Radius         | `12.r`      |
// | Icon Size             | `24.sp`     |
// | Border Width          | `1` (fixed) |
// | Divider Thickness     | `1` (fixed) |
// | Horizontal Padding    | `16.w`      |
// | Vertical Padding      | `12.h`      |
// | Margin Left/Right     | `16.w`      |
// | Margin Top/Bottom     | `12.h`      |
// | Square Padding/Margin | `12.w`      |

