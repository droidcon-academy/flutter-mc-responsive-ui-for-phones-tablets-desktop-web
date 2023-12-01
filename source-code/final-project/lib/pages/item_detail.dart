import 'package:flutter/material.dart';
import 'package:responsive_split_screen/helpers/constants.dart';
import 'package:responsive_split_screen/helpers/themes.dart';
import 'package:responsive_split_screen/models/carts_model.dart';
import 'package:responsive_split_screen/state/item_state.dart';
import 'package:responsive_split_screen/widgets/title_gradient_bar.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({super.key});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late ItemState itemState = ItemState.of(context)!;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TIP: For Tablet, Desktop, and Web
    //      Scroll GridView to the Top when selected Item Changes
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.minScrollExtent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D E T A I L'),
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        elevation: 2,
      ),
      // TIP: Use SafeArea with left: false for landscape scenarios if
      //      Detail Page Content needs it according to content layout
      //      left: false allows to use page content all the way to the left
      //      side of the List Page Split-Screen
      body: ValueListenableBuilder(
        valueListenable: itemState.itemSelectedNotifier,
        builder: (
          BuildContext context,
          Cart itemSelected,
          Widget? child,
        ) {
          return itemSelected.products.isEmpty
              ? const Center(
                  // Sets its height to the child's height multiplied by this factor.
                  heightFactor: 2,
                  child: Icon(
                    Icons.shopping_basket_rounded,
                    size: Sizes.iconLarge,
                    color: Colors.grey,
                    shadows: [Shadow(color: Colors.grey, blurRadius: 12.0)],
                  ),
                )
              : GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Sizes.imageHeight,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return DefaultTextStyle(
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: ThemeColors.titleBarText,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // TIP: macOS - Without the com.apple.security.network.client
                          //      entitlement, for example, network requests
                          //      fail with a message such as:
                          //      Without the com.apple.security.network.server
                          // https://docs.flutter.dev/platform-integration/macos/building
                          //      macOS DebugProfile.entitlements file add the following:
                          //      <key>com.apple.security.network.client</key>
                          //      <true/>
                          //      <key>com.apple.security.network.server</key>
                          //      <true/>
                          Image.network(
                            itemSelected.products[index].thumbnail,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),

                          // Title Gradient Bar
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: TitleGradientBar(
                              title: itemSelected.products[index].title,
                              price: itemSelected.products[index].price,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: itemSelected.products.length,
                );
        },
      ),
    );
  }
}
