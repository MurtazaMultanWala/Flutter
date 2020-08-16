import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../Screen/user_product_screen.dart';
import '../Screen/order_placed_screen.dart';
import '../helpers/custom_route_animation.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Hello Friends!"),
            automaticallyImplyLeading: false,
          ),
          Divider(), //horizontal line

          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),

          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrderPlacedScreen.routeName);
              // Navigator.of(context).pushReplacement(CustomRouteAnimation(
              //   builder: (ctx) => OrderPlacedScreen(),
              // ));
            },
          ),

          Divider(), //horizontal line

          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("/");
              Provider.of<Auth>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
