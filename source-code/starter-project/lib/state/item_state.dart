import 'package:flutter/material.dart';
import 'package:responsive_split_screen/models/carts_model.dart';

class ItemState extends InheritedWidget {
  const ItemState({
    super.key,
    required this.selectedIndex,
    required this.itemSelectedNotifier,
    required this.colorsList,
    required this.setItemIndex,
    required super.child,
  });

  final int selectedIndex;
  final ValueNotifier<Cart> itemSelectedNotifier;
  final List<Color?> colorsList;
  final Function setItemIndex;

  static ItemState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ItemState>();
  }

  @override
  bool updateShouldNotify(ItemState oldWidget) {
    return selectedIndex != oldWidget.selectedIndex;
  }
}
