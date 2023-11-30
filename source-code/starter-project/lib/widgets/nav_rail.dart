import 'package:flutter/material.dart';
import 'package:responsive_split_screen/helpers/constants.dart';

class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor:
          Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
      labelType: NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Icon(
          Icons.whatshot,
          size: Sizes.iconMedium,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.shopping_cart),
          label: Text('Carts'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bar_chart),
          label: Text('Dashboard'),
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
