import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screen/products_overview_screen.dart';
import './Screen/product_detail_screen.dart';
import './helpers/custom_route_animation.dart';
import './Screen/user_product_screen.dart';
import './providers/products_provider.dart';
import './Screen/order_placed_screen.dart';
import './Screen/edit_add_product.dart';
import './Screen/splash_screen.dart';
import './Screen/auth_screen.dart';
import './Screen/cart_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            update: (ctx, auth, previousProducts) => ProductsProvider(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
            // value: ProductsProvider(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, authData, _) => MaterialApp(
            title: 'My Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.orange,
              fontFamily: "Lato",
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransactionBuilder(),
                  TargetPlatform.iOS: CustomPageTransactionBuilder(),
                },
              ),
            ),
            home: authData.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: authData.autoLoginSuccessOnAppStart(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderPlacedScreen.routeName: (ctx) => OrderPlacedScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditAddProductScreen.routeName: (ctx) => EditAddProductScreen(),
            },
          ),
        ));
  }
}
