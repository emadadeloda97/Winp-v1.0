// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:WINP/GetX/controller/Controllers.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:WINP/GetX/views/SellPlaces.dart';

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
        automaticallyImplyLeading: false,
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

class TextToast {
  static show(String content,
      {int duration = 1,
      Color bgc = const Color.fromARGB(255, 112, 109, 109)}) {
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM_LEFT,
      backgroundColor: bgc,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }
}

class LoadingToast {
  static LoadingToast instance = LoadingToast._internal();
  factory LoadingToast() => instance;
  LoadingToast._internal();

  BuildContext context = Get.overlayContext!;
  bool needToRemove = true;
  late OverlayEntry overlayEntry;

  void show({String message = "", double seconds = 3}) {
    overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: Color.fromARGB(207, 236, 228, 228),
        child: Center(
          child: Container(
            width: Get.width * 0.3,
            height: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 172, 165, 165).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: message == ""
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround,
                children: [
                  CircularProgressIndicator(strokeWidth: 3),
                  _buildText(message),
                ],
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(Get.overlayContext!)?.insert(overlayEntry);
    needToRemove = true;
    final millisecond = (seconds * 1000).toInt();
    Future.delayed(Duration(milliseconds: millisecond)).then((value) {
      if (needToRemove) {
        overlayEntry.remove();
      }
    });
  }

  static Widget _buildText(String message) {
    return message == ""
        ? SizedBox()
        : Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: ArabicStyle(fontSize: 17, color: Colors.white),
          );
  }
}

class BasicDateField extends StatelessWidget {
  const BasicDateField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      Obx(
        (() => DateTimeField(
              enabled: true,
              textAlign: TextAlign.center,
              style: ArabicStyle(),
              controller: myInfo.dateSelected.value,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  icon: Icon(Icons.today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              format: format,
              resetIcon: null,
              onSaved: (d) => myInfo.updateDateSelected(d),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(2022),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2030));
              },
            )),
      )
    ]);
  }
}
