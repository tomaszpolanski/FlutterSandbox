import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/pages/HomePage.dart';
import 'package:flutter_view/pages/QrCodePage.dart';

class Routes {

  static String kHomePage = "/home";
  static String kQrCodesPage = "/home/qrcodes";

  static final Router router = new Router();


  static void configureRoutes() {
    router.define(kHomePage, handler: homeHandler);
    router.define(kQrCodesPage, handler: qrCodeHandler);
  }

}

final homeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new HomePage();
});


final qrCodeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new QrCodePage();
});
