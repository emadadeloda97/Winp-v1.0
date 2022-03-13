// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oda_tables/GetX/controller/Controllers.dart';

TextStyle ArabicStyle({double? fontSize, weight, Color? color}) {
  return TextStyle(
      fontFamily: 'Cairo',
      fontSize: fontSize ?? 25,
      fontWeight: weight,
      color: color ?? Colors.black);
}

RoundedRectangleBorder roundBorder() {
  return const RoundedRectangleBorder(
      side: BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(18)));
}

BoxDecoration containerDecoration() {
  return BoxDecoration(
      border: Border.all(color: Colors.blue, width: 3),
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      color: Colors.blue[50]);
}

RadialGradient AppBarGradientLight() {
  return const RadialGradient(colors: [
    Color(0xffECF72A),
    Color(0xffE6FF88),
    Color.fromARGB(255, 0, 213, 255),
    Color.fromARGB(255, 0, 173, 253),
  ], stops: [
    0.11,
    0.17,
    0.53,
    1
  ], radius: 1.5, center: Alignment(-0.9, -0.8));
}

RadialGradient AppBarGradientDark() {
  return const RadialGradient(colors: [
    Color.fromRGBO(232, 235, 237, 1),
    Color.fromRGBO(93, 100, 150, 1),
    Color.fromRGBO(58, 64, 96, 1),
    Color.fromRGBO(27, 31, 83, 1),
  ], stops: [
    0.05,
    0.08,
    0.13,
    0.21
  ], radius: 3, center: Alignment(0.86, -0.24));
}

LinearGradient BottomBarGradientLight() {
  return const LinearGradient(colors: [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromRGBO(0, 211, 255, 1),
    Color.fromRGBO(42, 182, 210, 1),
    Color.fromRGBO(29, 128, 227, 1),
  ], stops: [
    0.00,
    0.25,
    0.50,
    0.75
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

LinearGradient BottomBarGradientDark() {
  return const LinearGradient(
    colors: [
      Color.fromARGB(255, 175, 171, 165),
      Color.fromRGBO(93, 100, 150, 1),
      Color.fromRGBO(58, 64, 96, 1),
      Color.fromRGBO(27, 31, 83, 1),
    ],
    stops: [0.00, 0.25, 0.50, 0.75],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// ignore: must_be_immutable
class MyBottomAppBar extends StatelessWidget {
  Row? child;
  final MyInfo myInfo;
  MyBottomAppBar({
    Key? key,
    this.child,
    required this.myInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: (myInfo.isDark)
            ? const Color.fromARGB(255, 175, 171, 165)
            : const Color.fromARGB(255, 255, 255, 255),
        child: Container(
            height: 90,
            decoration: BoxDecoration(
                color: (myInfo.isDark)
                    ? const Color.fromARGB(255, 175, 171, 165)
                    : const Color.fromARGB(255, 255, 255, 255),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                gradient: (myInfo.isDark)
                    ? BottomBarGradientDark()
                    : BottomBarGradientLight()),
            child: child));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Text title;
  const MyAppBar({Key? key, required this.myInfo, required this.title})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  final MyInfo myInfo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: null,
        toolbarHeight: 80,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                gradient: (myInfo.isDark)
                    ? AppBarGradientDark()
                    : AppBarGradientLight())),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        title: title);
  }
}
