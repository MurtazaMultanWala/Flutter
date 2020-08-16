import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditAddProductScreen extends StatefulWidget {
  static const routeName = "/edit-add-product-screen";

  @override
  _EditAddProductScreenState createState() => _EditAddProductScreenState();
}

class _EditAddProductScreenState extends State<EditAddProductScreen> {
  /*Here Focus node is used to transacting to next field from current field
  since TextFormField donot have built in method to move to next field on
  pressing next button we need to create this focus node and add to both the
  Field as Focus node parameter to destination field and onFieldSubmitted 
  to the current field to link eachother.*/
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  /*The reason to add this manual TextEditing Controller besides the Form itself
  provides that to us is, We need the image url to be fetch by this controller so
  that we can preview the image using that url at the time of form editing not
  after submission. */
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  /*This Property is used to access the form attributes from the form widget */
  final _formWidgetAccessKey = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: null,
    title: "",
    description: "",
    price: 0.0,
    imageUrl: "",
  );

  var _isInit = true;
  var _isLoading = false;

  /*Incase of editing the pafe we need to show the tapped product details so
  this will the variable which holds the current data by editing its value
  fetching the data from the product items, i.e. in didChangeDependencies method */
  var _intiValues = {
    "title": "",
    "description": "",
    "price": "", // since form fields accept string
    "imageUrl": "",
  };

  /*use to listen the imageUrlFocusNode when move over the url field it must be
  changed. so we are setting up listener in initState method. */
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageurl);
    super.initState();
  }

/* Used for extracting the id argument from user product item since initState 
do not except the Modal.of(context).setting.arg*/
  // it always runs when page is open
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _intiValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price
              .toString(), // since form fields accept string
          "imageUrl": "",
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  void _updateImageurl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((_imageUrlController.text.startsWith("http") &&
              !_imageUrlController.text.startsWith("https")) ||
          (!_imageUrlController.text.endsWith(".png") &&
              !_imageUrlController.text.endsWith(".jpg") &&
              !_imageUrlController.text.endsWith(".jpeg"))) return;

      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formWidgetAccessKey.currentState.validate();

    if (!isValid) return;

    _formWidgetAccessKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        // .catchError((error) {
        // return showDialog(
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An Error Occured!"),
            content: Text(
              "Something Went Wrong",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   // }).then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // });
  }

  /*Delete the assigned memory when the work is finished*/
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageurl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit/Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formWidgetAccessKey,
                //user input form
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _intiValues['title'],
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Please Enter a Value";
                        if (value.length < 5)
                          return "Title should be atleast 5 characters long";
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          title: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                        initialValue: _intiValues['price'],
                        decoration: InputDecoration(labelText: "Price"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) return "Please enter a price";
                          if (double.parse(value) == null)
                            return "Please enter a valid number";
                          if (double.parse(value) <= 0)
                            return "Number must be greater than zero";
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value),
                            imageUrl: _editedProduct.imageUrl,
                          );
                        }),
                    TextFormField(
                        initialValue: _intiValues["description"],
                        decoration: InputDecoration(labelText: "Description"),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter a description";
                          if (value.length < 10)
                            return "Description should be atleast 10 characters long";
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            description: value,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                          );
                        }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text("Enter an URL")
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Image URl"),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_) => _saveForm(),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter an Image URL";
                                if (!value.startsWith("http") &&
                                    !value.startsWith("https"))
                                  return "Please Enter valid URL";
                                if (!value.endsWith(".png") &&
                                    !value.endsWith(".jpg") &&
                                    !value.endsWith(".jpeg"))
                                  return "Please enter a valid Image URL";

                                return null;
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value,
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
