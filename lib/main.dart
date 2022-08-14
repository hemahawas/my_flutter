import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_project/layout/news_app/cubit/cubit.dart';
import 'package:my_project/layout/news_app/news_layout.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/social_layout.dart';
import 'package:my_project/shared/components/constants.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/social_app/social_login/cubit/cubit.dart';
import 'package:my_project/modules/social_app/social_login/social_login_screen.dart';
import 'package:my_project/modules/social_app/social_register/cubit/cubit.dart';
import 'package:my_project/shared/bloc_observer.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';
import 'package:my_project/shared/network/remote/dio_helper.dart';
import 'package:my_project/shared/styles/themes.dart';

void main() async {
  //try {
  WidgetsFlutterBinding.ensureInitialized();

  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (e) {
  //   print(e.toString());
  // }
  //
  // var token = await FirebaseMessaging.instance.getToken();
  //
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  // });
  //
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  // );

  DioHelper.init();
  await CacheHelper.init();
  bool isDarkMain = CacheHelper.getData(key: 'isDark') ?? false;

  if (Platform.isWindows)
    await DesktopWindow.setMinWindowSize(Size(350.0, 650.0));

  Widget widget;
  //bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;

  uId = CacheHelper.getData(key: 'uId') ?? '';

  if (uId == '') {
    widget = SocialLoginScreen();
  } else {
    widget = SocialLayout();
  }

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(
        MyApp(
          isDarkApp: isDarkMain,
          startWidget: widget,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late bool isDarkApp;
  late Widget startWidget;
  MyApp({
    required this.isDarkApp,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getUsers(),
        ),
        BlocProvider(
          create: (context) => SocialLoginCubit(),
        ),
        BlocProvider(
          create: (context) => SocialRegisterCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: isDarkApp ? ThemeMode.dark : ThemeMode.light,
        home: NewsLayout(),
      ),
    );
  }
}
