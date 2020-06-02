import 'package:flutter/material.dart';
import 'package:iwas_port/Models/CartItem.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Services/LocationDatabaseService.dart';
import 'package:iwas_port/Services/WineDatabaseService.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => {..._cartItems};

  int get cartItemCount {
    if (_cartItems.length == 0) {
      return 0;
    } else {
      int totalQuantity = 0;
      _cartItems.forEach((key, cartItem) {
        totalQuantity += cartItem.quantity;
      });
      return totalQuantity;
    }
  }

  double get totalAmount {
    double totalAmount = 0.0;
    _cartItems.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.quantity;
    });
    return totalAmount;
  }

  void addCartItem(CartItem cartItem) {
    if (_cartItems.containsKey(cartItem.id)) {
      _cartItems.update(
          cartItem.id,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                manufacturer: existingCartItem.manufacturer,
                type: existingCartItem.type,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
                imageURL: existingCartItem.imageURL,
                maxStockQuantity: existingCartItem.maxStockQuantity,
              ));
    } else {
      _cartItems.putIfAbsent(
          cartItem.id,
          () => CartItem(
              id: cartItem.id,
              imageURL: cartItem.imageURL,
              manufacturer: cartItem.manufacturer,
              type: cartItem.type,
              quantity: 1,
              price: cartItem.price,
              maxStockQuantity: cartItem.maxStockQuantity));
    }
    notifyListeners();
  }

  void deleteCartItem(CartItem cartItem) {
    if (_cartItems.containsKey(cartItem.id)) {
      _cartItems.update(
          cartItem.id,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                manufacturer: existingCartItem.manufacturer,
                type: existingCartItem.type,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                imageURL: existingCartItem.imageURL,
                maxStockQuantity: existingCartItem.maxStockQuantity,
              ));
    } else {
      removeCartItem(cartItem.id);
    }
    notifyListeners();
  }

  void removeCartItem(String productID) {
    _cartItems.remove(productID);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }

  Wine findProductFromCart(List<Wine> productList, CartItem cartItem) {
    Wine product = Wine.empty();

    for (int i = 0; i < productList.length; i++) {
      if (productList[i].docID == cartItem.id) {
        product = productList[i];
      }
    }
    return product;
  }

  Wine findProductFromLocation(List<Wine> productList, CartItem cartItem) {
    Wine product = Wine.empty();
    bool existent = false;

    if (productList.isEmpty){
      return null;
    }

    for (int i = 0; i < productList.length; i++) {
      if (productList[i].docID == cartItem.id) {
        product = productList[i];
        existent = true;
      }
    }

    if (existent) {
      return product;
    } else {
      return null;
    }
  }

  bool updateProduct(List<Wine> productList, String method) {
    bool isValid;

    try {
      final cartItemList = _cartItems.values.toList();
      Wine product = Wine.empty();
      cartItemList.forEach((cartItem) {
        product = findProductFromCart(productList, cartItem);

        if (method == 'Verkaufen') {
          product.quantity -= cartItem.quantity;
        } else if (method == 'Kaufen') {
          product.quantity += cartItem.quantity;
        } else if (method == 'Transfer') {
          product.quantity = product.quantity;
        }
        WineDatabaseService().writeToDatabase(product);
        isValid = true;
      });
    } catch (error) {
      isValid = false;
    }
    return isValid;
  }

  void updateLocationOnBuy(Location locationToUpdate, List<Wine> productList) {
    final cartItemList = _cartItems.values.toList();
    Wine foundProduct;
    Wine toProduct;

    try {
      cartItemList.forEach((cartItem) {
        foundProduct =
            findProductFromLocation(locationToUpdate.productList, cartItem);

        if (foundProduct == null) {
          foundProduct = findProductFromLocation(productList, cartItem);
          toProduct = Wine(
              docID: foundProduct.docID,
              imageURL: foundProduct.imageURL,
              sellingPrice: foundProduct.sellingPrice,
              manufacturer: foundProduct.manufacturer,
              productID: foundProduct.productID,
              purchasePrice: foundProduct.purchasePrice,
              type: foundProduct.type,
              quantity: foundProduct.quantity,
              criticalQuantity: foundProduct.criticalQuantity);
          toProduct.quantity = cartItem.quantity;
          locationToUpdate.productList.add(toProduct);
        } else {
          foundProduct.quantity += cartItem.quantity;
        }

        LocationDatabaseService().writeToDatabase(locationToUpdate);
      });
    } catch (error) {}
  }

  void updateLocationOnSell(Location locationToUpdate, List<Wine> productList) {
    final cartItemList = _cartItems.values.toList();
    Wine foundProduct;


    cartItemList.forEach((cartItem) {
      foundProduct =
          findProductFromLocation(locationToUpdate.productList, cartItem);
        if (foundProduct.quantity >= cartItem.quantity) {
          foundProduct.quantity -= cartItem.quantity;
          LocationDatabaseService().writeToDatabase(locationToUpdate);
      }
    });
  }

  void updateLocationOnTransfer(
      Location from, Location to, List<Wine> productList) {
    final cartItemList = _cartItems.values.toList();
    Wine foundToProduct;
    Wine foundFromProduct;
    Wine toProduct;


    cartItemList.forEach((cartItem) {
      foundFromProduct = findProductFromLocation(from.productList, cartItem);
      foundToProduct = findProductFromLocation(to.productList, cartItem);

      if (foundToProduct == null) {
        foundToProduct = findProductFromLocation(productList, cartItem);
        toProduct = Wine(
            docID: foundToProduct.docID,
            imageURL: foundToProduct.imageURL,
            sellingPrice: foundToProduct.sellingPrice,
            manufacturer: foundToProduct.manufacturer,
            productID: foundToProduct.productID,
            purchasePrice: foundToProduct.purchasePrice,
            type: foundToProduct.type,
            quantity: foundToProduct.quantity,
            criticalQuantity: foundToProduct.criticalQuantity);
        toProduct.quantity = cartItem.quantity;
        to.productList.add(toProduct);
      } else {
        foundToProduct.quantity += cartItem.quantity;
      }

      if (foundFromProduct == null) {
        foundFromProduct = findProductFromLocation(productList, cartItem);
      } else {
        if (foundFromProduct.quantity >= cartItem.quantity) {

          foundFromProduct.quantity -= cartItem.quantity;

          LocationDatabaseService().writeToDatabase(from);
          LocationDatabaseService().writeToDatabase(to);
        }
      }
    });
  }

  bool validateLocationOnBuy(
      Location locationToUpdate, List<Wine> productList) {
    final cartItemList = _cartItems.values.toList();
    Wine toProduct = Wine.empty();
    bool isValid;
    try {
      cartItemList.forEach((cartItem) {
        toProduct =
            findProductFromLocation(locationToUpdate.productList, cartItem);
        if (toProduct == null) {
          toProduct = findProductFromLocation(productList, cartItem);
        }
        isValid = true;
      });
    } catch (error) {
      isValid = false;
    }
    return isValid;
  }

  List<bool> validateLocationOnSell(
      Location locationToUpdate, List<Wine> productList) {
    final cartItemList = _cartItems.values.toList();
    Wine fromProduct = Wine.empty();
    bool isValid;
    bool isNoError;

    cartItemList.forEach((cartItem) {
      fromProduct =
          findProductFromLocation(locationToUpdate.productList, cartItem);
      if (fromProduct == null) {
        isNoError = false;
      } else {
        if (fromProduct.quantity >= cartItem.quantity) {
          isNoError = true;
          isValid = true;
        } else {
          isNoError = true;
          isValid = false;
        }
      }
    });
    return [isNoError, isValid];
  }

  List<bool> validateLocationOnTransfer(
      Location from, Location to, List<Wine> productList) {
    final cartItemList = _cartItems.values.toList();
    Wine toProduct = Wine.empty();
    Wine fromProduct = Wine.empty();
    bool isValid;
    bool isNoError;

    cartItemList.forEach((cartItem) {
      fromProduct = findProductFromLocation(from.productList, cartItem);
      toProduct = findProductFromLocation(to.productList, cartItem);

      if (toProduct == null) {
        toProduct = findProductFromLocation(productList, cartItem);
      }

      if (fromProduct == null) {
        isNoError = false;
      } else {
        if (fromProduct.quantity >= cartItem.quantity) {
          isNoError = true;
          isValid = true;
        } else {
          isNoError = true;
          isValid = false;
        }
      }
    });
    return [isNoError, isValid];
  }
}
