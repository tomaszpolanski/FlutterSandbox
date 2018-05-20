import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/pages/HomePage.dart';
import 'package:flutter_view/features/photoview/PhotoListPage.dart';
import 'package:flutter_view/pages/PushNotificationPage.dart';
import 'package:flutter_view/pages/MultiChildLayout.dart';
import 'package:flutter_view/pages/ReduxPage.dart';
import 'package:flutter_view/features/silvers/Sliver1.dart';
import 'package:flutter_view/features/silvers/Sliver2.dart';

class Routes {

  static String kHomePage = "/home";
  static String kQrCodesPage = "/home/qrcodes";
  static String kPush = "/home/push";
  static String kRedux = "/home/redux";
  static String kPhotoView = "/home/photoview";
  static String kSliver1 = "/home/sliver1";
  static String kSliver2 = "/home/sliver2";

  static final Router router = new Router();


  static void configureRoutes() {
    router.define(kHomePage, handler: homeHandler);
    router.define(kQrCodesPage, handler: new Handler(handlerFunc: (_, __) => new MultiChildLayout()));
    router.define(kPush, handler: pushHandler);
    router.define(kRedux, handler: reduxHandler);
    router.define(kPhotoView, handler: photoHandler);
    router.define(kSliver1, handler: new Handler(handlerFunc: (_, __) => new Sliver1()));
    router.define(kSliver2, handler: new Handler(handlerFunc: (_, __) => new Sliver2()));
  }

}

final homeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new HomePage();
});


final pushHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new PushNotificationPage();
});

final reduxHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new ReduxPage();
});

final photoHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new PhotoListPage();
});
