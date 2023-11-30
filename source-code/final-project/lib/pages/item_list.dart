import 'package:flutter/material.dart';
import 'package:responsive_split_screen/helpers/constants.dart';
import 'package:responsive_split_screen/helpers/formatters.dart';
import 'package:responsive_split_screen/models/carts_model.dart';
import 'package:responsive_split_screen/pages/item_detail.dart';
import 'package:responsive_split_screen/state/item_state.dart';

/// TIP: Set [PageStorageBucket] as Global to remember scrolled position
final PageStorageBucket pageStorageBucket = PageStorageBucket();

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    // TIP: When running on phone, no Split-Screen, we use Nested Navigator
    //      showing List page, and allowing navigation from List to Detail page
    // TIP: When running on Tablet, Desktop, and Web show List page
    //      since it's part of the Split-Screen
    // TIP: Takes account device view size, great when resizing or changing orientation
    //      it gives the width of the current rendered view
    return switch (ResponsiveSizes.whichDevice()) {
      ResponsiveSizes.mobile => Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const BuildListViewSeparated(),
            );
          },
        ),
      ResponsiveSizes.tablet ||
      ResponsiveSizes.desktopWeb =>
        const BuildListViewSeparated(),
    };
  }
}

class BuildListViewSeparated extends StatefulWidget {
  const BuildListViewSeparated({super.key});

  @override
  State<BuildListViewSeparated> createState() => _BuildListViewSeparatedState();
}

class _BuildListViewSeparatedState extends State<BuildListViewSeparated> {
  late ItemState itemState;
  late Cart _itemSelected;
  final CartsModel _itemsList = CartsModel.loadDataJson();
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    itemState = ItemState.of(context)!;
    _itemSelected = itemState.itemSelectedNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('L I S T'),
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        elevation: 2,
      ),
      body: PageStorage(
        bucket: pageStorageBucket,
        child: ListView.separated(
          key: const PageStorageKey<String>('scrollPosition'),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              minVerticalPadding: 16.0,
              leading: Badge.count(
                count: _itemsList.carts[index].totalQuantity,
                largeSize: Sizes.badgeLargeSize,
                offset: const Offset(4, -15),
                child: Icon(
                  Icons.shopping_cart,
                  color: itemState.colorsList[index],
                  size: Sizes.iconSmall,
                ),
              ),
              title: Text(
                _itemsList.carts[index].products.first.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              subtitle: Text(
                Format.toCurrency(_itemsList.carts[index].total),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              selected: ResponsiveSizes.whichDevice() == ResponsiveSizes.mobile
                  ? false
                  : (itemState.selectedIndex == index),
              selectedTileColor: Theme.of(context).focusColor,
              onTap: () {
                _itemSelected = _itemsList.carts[index];
                itemState.setItemIndex(index);
                itemState.itemSelectedNotifier.value = _itemSelected;

                if (ResponsiveSizes.whichDevice() == ResponsiveSizes.mobile) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ItemDetail(),
                    ),
                  );
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: _itemsList.carts.length,
        ),
      ),
    );
  }
}
