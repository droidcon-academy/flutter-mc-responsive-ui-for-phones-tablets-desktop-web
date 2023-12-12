import 'package:flutter/material.dart';
import 'package:responsive_split_screen/helpers/constants.dart';
import 'package:responsive_split_screen/helpers/themes.dart';
import 'package:responsive_split_screen/models/carts_model.dart';
import 'package:responsive_split_screen/state/item_state.dart';
import 'package:responsive_split_screen/widgets/nav_bar.dart';
import 'package:responsive_split_screen/widgets/nav_rail.dart';
import 'package:responsive_split_screen/widgets/responsive_layout_builder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex;
  late ValueNotifier<Cart> _itemSelectedNotifier;
  List<Color?> _colorsList = [];
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
    _itemSelectedNotifier = ValueNotifier<Cart>(Cart.blankDefaultValues());
    _colorsList = RandomColorList.colors();
  }

  void _setItemIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TIP: ItemState remembers selected item and allows refresh of detail page
    return ItemState(
      selectedIndex: _selectedIndex,
      itemSelectedNotifier: _itemSelectedNotifier,
      colorsList: _colorsList,
      setItemIndex: _setItemIndex,
      child: ResponsiveLayoutBuilder(
        mobile: Scaffold(
          body: IndexedStack(
            index: _currentPageIndex,
            children: SelectedPage.bodySelectedPage,
          ),
          bottomNavigationBar: NavBar(
            selectedIndex: _currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
        ),
        tablet: Scaffold(
          body: IndexedStack(
            index: _currentPageIndex,
            children: SelectedPage.bodySelectedPageSplitScreen,
          ),
          bottomNavigationBar: NavBar(
            selectedIndex: _currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
        ),
        desktopWeb: Scaffold(
          body: Row(
            children: [
              // TIP: This is only used if Window is resized vertically smaller
              //      than the NavigationRail height
              //      SingleChildScrollView -> Container .. BoxConstraints
              SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 300),
                  height: MediaQuery.sizeOf(context).height,
                  child: NavRail(
                    selectedIndex: _currentPageIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                  ),
                ),
              ),

              const VerticalDivider(width: Sizes.verticalDividerWidth),

              Expanded(
                child: IndexedStack(
                  index: _currentPageIndex,
                  children: SelectedPage.bodySelectedPageSplitScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
