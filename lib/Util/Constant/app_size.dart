import 'package:flutter/material.dart';

 const double defaultRadius = 10.00;
 const double defaultPadding = 16.00;
 const double defaultMargin = 16.00;
class AppSize {

  static const hGap3 = SizedBox(height: 3);
  static const hGap5 = SizedBox(height: 5);
  static const hGap8 = SizedBox(height: 8);
  static const hGap10 = SizedBox(height: 10);
  static const hGap15 = SizedBox(height: 15);
  static const hGap30 = SizedBox(height: 30);

  static const wGap5 = SizedBox(width: 5);
  static const wGap8 = SizedBox(width: 8);
  static const wGap10 = SizedBox(width: 10);
  static const wGap16 = SizedBox(width: 16);
  static const wGap30 = SizedBox(width: 30);


  /// MediaQuery
  static double displayWidth(context){
    return MediaQuery.of(context).size.width;
  }

  static double displayHeight(context){
    return MediaQuery.of(context).size.height;
  }

  static double displayStatus(context){
    return MediaQuery.of(context).padding.top;
  }

  static double displayFontSize(context){
    return displayWidth(context)+displayWidth(context)+displayStatus(context);
  }

  static double horizontalPadding12(context){
    return MediaQuery.of(context).size.width * 12/360;
  }

  static double horizontalPadding6(context){
    return MediaQuery.of(context).size.width * 6/360;
  }

  static double horizontalPadding16(context){
    return MediaQuery.of(context).size.width * 16/360;
  }
  static double horizontalPadding24(context){
    return MediaQuery.of(context).size.width * 24/360;
  }
  static double verticalPadding12(context){
    return MediaQuery.of(context).size.height * 12/800;
  }
  static double verticalPadding16(context){
    return MediaQuery.of(context).size.height * 16/800;
  }
  static double verticalPadding24(context){
    return MediaQuery.of(context).size.height * 24/800;
  }

}