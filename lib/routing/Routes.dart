import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/pages/HomePage.dart';
import 'package:flutter_view/pages/PhotoListPage.dart';
import 'package:flutter_view/pages/PushNotificationPage.dart';
import 'package:flutter_view/pages/QrCodePage.dart';
import 'package:flutter_view/pages/ReduxPage.dart';

class Routes {

  static String kHomePage = "/home";
  static String kQrCodesPage = "/home/qrcodes";
  static String kPush = "/home/push";
  static String kRedux = "/home/redux";
  static String kPhotoView = "/home/photoview";

  static final Router router = new Router();


  static void configureRoutes() {
    router.define(kHomePage, handler: homeHandler);
    router.define(kQrCodesPage, handler: qrCodeHandler);
    router.define(kPush, handler: pushHandler);
    router.define(kRedux, handler: reduxHandler);
    router.define(kPhotoView, handler: photoHandler);
  }

}

final homeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new HomePage();
});


final qrCodeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new QrCodePage();
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
