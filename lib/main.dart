import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/splash_screen/splash_screen.dart';
import 'package:rishtey/utils/firebase/app_notifications.dart';

import 'package:rishtey/utils/theme_clas.dart';

import 'controller/ImagePickerController.dart';
import 'controller/InterestListController.dart';
import 'controller/auth_controller.dart';
import 'controller/dashboard_controller.dart';
import 'controller/get_profile_controller.dart';
import 'controller/rating_controller.dart';
import 'controller/search_controller.dart';
import 'controller/update_controller.dart';
import 'firebase_options.dart';

FlutterLocalNotificationsPlugin ?flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true);
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  ///Get FCM Token..
  await AppNotificationHandler.getFcmToken();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var id;
  @override
  void initState() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification:onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin!.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    AppNotificationHandler.getInitialMsg();
    AppNotificationHandler.showMsgHandler();
    AppNotificationHandler.onMsgOpen();
    FirebaseMessaging.instance.getToken().then((String? fcm) {
      // AppData.fcmToken = "$fcm";
      print("FcmToken => $fcm");

    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
    ChangeNotifierProvider<AuthController>(
    create: (context) => AuthController(),
    ),
        ChangeNotifierProvider<ImagePickerController>(create: (context)=>ImagePickerController()),
        ChangeNotifierProvider<RatingController>(create: (context)=>RatingController()),
        ChangeNotifierProvider<GetProfileController>(create: (context)=>GetProfileController()),
        ChangeNotifierProvider<DashBoardController>(create: (context)=>DashBoardController()),
        ChangeNotifierProvider<SearchController>(create: (context)=>SearchController()),
        ChangeNotifierProvider<UpdateController>(create: (context)=>UpdateController()),
          ChangeNotifierProvider<InterestListController>(
              create: (context) => InterestListController()),
        ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
      ),
    );
  }
  // getNotifications(){
  //
  // }
  void selectNotification(String ?payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => SplashScreen()),
    );
  }

  void onDidReceiveLocalNotification(
      int ?id, String ?title, String ?body, String ?payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


