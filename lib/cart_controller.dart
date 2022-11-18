import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:my_provider/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends ChangeNotifier {
  List<CartBean> _items = [];

  CartController() {
    _loadSPData();
  }

  _loadSPData() async {
    print("In constructor of CartController");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString("cart");
    if (jsonData != null) {
      List jsonArr = json.decode(jsonData);
      _items = jsonArr.map((e) => CartBean.fromJson(e)).toList();
      print("Cart Loaded " + _items.length.toString());
      notifyListeners();
    }
  }

  void add(Product product) {
    _items.add(
      CartBean(
          name: product.name,
          qty: 1,
          id: product.id,
          price: product.price,
          discount: 10),
    );
    saveData();
    notifyListeners();
  }

  CartBean? cartGetList(int id) {
    for (int i = 0; i < _items.length; i++) {
      if (id == _items[i].id) {
        return _items[i];
      }
    }
    return null;
  }

  void remove(int id) {
    for (int i = 0; i < _items.length; i++) {
      if (id == _items[i].id) {
        _items.removeAt(i);
      }
    }

    notifyListeners();
  }

  List<CartBean> getList() {
    return _items;
  }

  void incrQty(int id) {
    CartBean product = _items.firstWhere((element) => element.id == id);
    product.qty = product.qty + 1;
    notifyListeners();
    saveData();
  }

  void decrQty(CartBean product) {
    product.qty = product.qty - 1;
    notifyListeners();
    saveData();
  }

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', json.encode(_items));
  }
}
