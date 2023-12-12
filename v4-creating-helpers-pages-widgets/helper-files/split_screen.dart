import 'package:flutter/material.dart';
import 'package:responsive_split_screen/helpers/constants.dart';
import 'package:responsive_split_screen/pages/item_detail.dart';
import 'package:responsive_split_screen/pages/item_list.dart';

class SplitScreen extends StatelessWidget {
  const SplitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // List
        SizedBox(
          width: Sizes.listWidth,
          child: ItemList(),
        ),

        VerticalDivider(width: Sizes.verticalDividerWidth),

        // Details
        Expanded(child: ItemDetail()),
      ],
    );
  }
}
