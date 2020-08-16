import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showIsFavorite;

  ProductsGrid(this.showIsFavorite);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final productItem =
        showIsFavorite ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: productItem.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        /*alternative way when not dependent on context u can use .value*/
        // builder: (ctx) => productItem[index],
        value: productItem[index],
        child: ProductItem(
            // productItem[index].id,
            // productItem[index].title,
            // productItem[index].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //how many column u need on screen
        childAspectRatio: 3 / 2, //spacing between each grid ratio
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
