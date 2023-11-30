import 'package:flutter/material.dart';
import 'package:responsive_split_screen/pages/dashboard.dart';
import 'package:responsive_split_screen/pages/item_list.dart';
import 'package:responsive_split_screen/pages/split_screen.dart';

enum ResponsiveSizes {
  mobile,
  tablet,
  desktopWeb;

  // TODO: Add logic
  static ResponsiveSizes whichDevice() {
    return ResponsiveSizes.mobile;
  }
}

class Sizes {
  static const imageHeight = 580.0;
  static const iconLarge = 128.0;
  static const iconMedium = 38.0;
  static const iconSmall = 32.0;
  static const badgeLargeSize = 20.0;
  static const listWidth = 320.0;
  static const verticalDividerWidth = 1.0;
}

class SelectedPage {
  static final List<Widget> bodySelectedPage = <Widget>[
    const ItemList(),
    const Dashboard(),
  ];

  static final List<Widget> bodySelectedPageSplitScreen = <Widget>[
    const SplitScreen(),
    const Dashboard(),
  ];
}
