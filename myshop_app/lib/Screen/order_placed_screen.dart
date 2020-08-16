import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_placed_item.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart';

class OrderPlacedScreen extends StatelessWidget {
  static const routeName = "/orders-placed-screen";

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Placed Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              // error handling stuff
              return Center(
                child:
                    Text("An Error Occured!  " + dataSnapshot.error.toString()),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (ctx, index) =>
                      OrderPlacedItem(ordersData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
