import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/* 
Product Procider makes easy in paasing values to child widgets using 
ProviderListerners it helps in easy access to the daat.
*/

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;
  ProductsProvider(this.authToken, this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prod) => prod.isFavorite).toList();
    // }

    /* ... means sending copy of items the reason is because
  in flutter every thing is object and passed by reference 
  sinces items are private and it must not accessible by
  any other file so we send copy od that. */
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterbyUserString =
        filterByUser ? "orderBy='creatorId'&equalTo='$userId'" : '';
    var url =
        "https://my-shop-flutter-3719c.firebaseio.com/products.json?auth=$authToken&$filterbyUserString";
    try {
      /*returns nested map as key of first map is the id generated by firebase itself
      and value of that key is another map having all the data corresponding to 
      that product id i.e. title, description, price etc.*/
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;

      /*Since we removed the isFavorite id from products to different storage link
      for specific user so we need to fetch that using differt url*/
      url =
          "https://my-shop-flutter-3719c.firebaseio.com/userFavorites/$userId.json?auth=$authToken";
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];

      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite:
                favoriteData == null ? false : favoriteData[productId] ?? false,
            //if id no fav means no product id so ?? checks if it is null so do that
          ),
        );
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  /*Returning Future so that we can show underprocess working on the screen while
  request is not completed and return to prev page. */
  Future<void> addProduct(Product product) async {
    /*Sending Snapshot to server as well */
    final url =
        "https://my-shop-flutter-3719c.firebaseio.com/products.json?auth=$authToken";

    /*async returns Future object so no need to return now. furthermore, to make
    await the code to execute once the requests is completed we use "await" keyword
    this works same like .then() it returns the response all by itself so we can
    use it afterwards.  One more thing await donot have any CatchError funtionality
    so we need to use try catch for that*/

    // return http.post()

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'creatorId': userId,
          // 'isFavorite': product.isFavorite,
        }),

        /*The then methods helps in waiting tille the response of the post
        request is recieved. */
      );

      final newProduct = Product(
        /*Since we are getting respomse against the completion of our request
        now we can assign the id auto generated by firebase instead of hardcoding 
        it. */

        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);

      // _items.insert(0, newProduct);  //for entering at the top of the list

      /*Since items is a provate list of products changing in the list cannot
        be viewed by other file or widgets so for that purpose ChangeNotifier
        provides this method. It makes a communication channel between them.*/
      notifyListeners();
    } catch (error) {
      /* Printing error in console is not solution it just prevent the app from
      crashing we need to handle that in app so that user should know that too
      so for that we are generating self made error of same error we get from 
      request and handle in the app to show on the screen.*/
      throw error;
    }

    // .then((response){})
    /*Managing Local as well we need data locally for managing the app
      we cna fetch from server.*/

    // }).catchError((error) {
    //   /* Printing error in console is not solution it just prevent the app from
    //   crashing we need to handle that in app so that user should know that too
    //   so for that we are generating self made error of same error we get from
    //   request and handle in the app to show on the screen.*/
    //   throw error;
    // });
  }

  Future<void> updateProduct(String productId, Product toUpdateProduct) async {
    final foundProductIndex = _items.indexWhere((prod) => prod.id == productId);
    if (foundProductIndex >= 0) {
      final url =
          "https://my-shop-flutter-3719c.firebaseio.com/products/$productId.json?auth=$authToken";

      // used to update the record
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': toUpdateProduct.title,
            'description': toUpdateProduct.description,
            'price': toUpdateProduct.price,
            'imageUrl': toUpdateProduct.imageUrl,
          }),
        );

        _items[foundProductIndex] = toUpdateProduct;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      print("...");
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url =
        "https://my-shop-flutter-3719c.firebaseio.com/products/$productId.json?auth=$authToken";

    final existingProductIndex =
        items.indexWhere((prod) => prod.id == productId);
    var existingProduct = items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    /*what if deleting fails for that usning async method we can loss the old value
    so we use this method known as optimistic updating method where we saved the
    old product data and if delete caught error we replace it with old one.*/

    final response = await http.delete(url); //.then((response) {
    if (response.statusCode >= 400) {
      items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(" Could not delete product.");
    }
    existingProduct = null;
  }
}