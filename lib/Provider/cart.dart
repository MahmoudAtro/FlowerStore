import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  List _cart = [];
  List get cart => _cart;
  double _totleprice = 0;
  double get totleprice => _totleprice;

  add(Map product) {
    bool productExists = _cart.any((item) => item['name'] == product['name']);
    if (!productExists) {
      product["quantity"] = 1;
      _cart.add(product);
      _totleprice += product["price"];
    }else{
      int index = _cart.indexWhere((item) => item['name'] == product['name']);
      _cart[index]["quantity"]++;
      _totleprice += product["price"];
    }

    notifyListeners();
  }

  deleteAll() {
    _cart.clear();
    _totleprice = 0;
    notifyListeners();
  }

  count() {
    return _cart.length;
  }

  totel() {
    return _totleprice.toInt();
  }

  addquantity(int index) {
    _cart[index]["quantity"]++;
    _totleprice += _cart[index]["price"];
    notifyListeners();
  }

  removequantity(int index) {
    if (_cart[index]["quantity"] > 1) {
      _cart[index]["quantity"]--;
      _totleprice -= _cart[index]["price"];
    } else {
      _totleprice -= _cart[index]["price"];
      _cart.removeAt(index);
    }
    notifyListeners();
  }
}
