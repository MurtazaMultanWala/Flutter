/* This dart file is responsible for making how 
each product item looks like*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../Screen/product_detail_screen.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context);
    final cartItem = Provider.of<Cart>(context, listen: false);
    final scaffold = Scaffold.of(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: productItem.id,
            );
            /*
            Easy to implement as it is created on fly but downside is
            in large app it is difficult to know on fly which screen 
            is navigated. Also, in ProductDetailScreen we need to show
            price of the product but this fike doesnot have that attribute
            one way to overcome is that we except as a additional arg
            in this file but it is not good to accept args which are
            not utilized in that file but is used to pass to other file
            for solving this issue we used """Routes for Nagivation""".

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(title),
              ),
            );*/
          },
          child: Hero(
            tag: productItem.id,
            child: FadeInImage(
              placeholder: AssetImage("assets\images\product-placeholder.png"),
              image: NetworkImage(productItem.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //footer of each grid tile
        footer: GridTileBar(
          backgroundColor: Colors.black87,

          /*Consumer is an alternative way to achieve Provide
         Listener changes, on listerner event, it runs on particular
         section and useful when you want a specific section to be rebuilt
         when listener is triggered not whole file.'
         

         Provide<> rebuilt entire page or not based on listener arg.
         */
          leading: Consumer<Product>(
            builder: (ctx, productItem, _) => IconButton(
              icon: Icon(productItem.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () async {
                try {
                  await productItem.toggleFavoriteStatus(
                    authData.token,
                    authData.userId,
                  );
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(error),
                    ),
                  );
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            productItem.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cartItem.addItem(
                  productItem.id, productItem.price, productItem.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added item to Cart!",
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cartItem.removeSingleItem(productItem.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
