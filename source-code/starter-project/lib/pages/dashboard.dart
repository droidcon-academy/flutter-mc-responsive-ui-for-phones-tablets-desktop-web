import 'package:flutter/material.dart';
import 'package:responsive_split_screen/models/carts_model.dart';
import 'package:responsive_split_screen/widgets/graph_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CartsModel _itemsList = CartsModel.loadDataJson();
  int itemDiscountToPlot = 0;
  int itemDiscountTotalToPlot = 0;
  int itemToPlotMax = 0;
  int itemTotalToPlotMax = 0;
  double itemTotalDiscountPercent = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotals();
  }

  void _calculateTotals() {
    int itemDiscountedTotal = 0;
    int itemTotal = 0;

    for (var cart in _itemsList.carts) {
      for (var product in cart.products) {
        itemDiscountedTotal += product.discountedPrice;
        itemTotal += product.total;
      }
    }
    setState(() {
      itemDiscountToPlot = itemDiscountedTotal;
      itemDiscountTotalToPlot = itemTotal;
      itemToPlotMax = itemTotal;
      itemTotalToPlotMax = itemTotal;
      itemTotalDiscountPercent =
          ((itemTotal - itemDiscountedTotal) / itemTotal) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D A S H B O A R D'),
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // TIP: Use FittedBox for Desktop if user resizes window very small
          child: Center(
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalBarWidget(
                    icon: Icons.shopping_cart,
                    numberToPlot: itemDiscountToPlot,
                    numberToPlotMax: itemDiscountTotalToPlot,
                    title:
                        '${itemTotalDiscountPercent.toStringAsFixed(0)}% Discounts',
                  ),
                  const Padding(padding: EdgeInsets.only(left: 56.0)),
                  VerticalBarWidget(
                    icon: Icons.shopping_cart,
                    numberToPlot: itemToPlotMax,
                    numberToPlotMax: itemTotalToPlotMax,
                    title: 'Retail',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
