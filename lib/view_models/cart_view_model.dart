import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/models/cart/cart_model.dart';
import 'package:golden_doctor/resources/services/hive.dart';
import 'package:hive/hive.dart';

final cartProvider =
    NotifierProvider<CartViewModel, List<CartModel>>(() => CartViewModel());

class CartViewModel extends Notifier<List<CartModel>> {
  @override
  List<CartModel> build() {
    return [];
  }

  int totalItemCount = 0;
  double totalItemPrice = 0.0;
  int getTotalItemCount() {
    return totalItemCount;
  }

  double calculateCartPrice() {
    double total = 0.0;
    state.map((e) {
      double itemPrice =
          double.parse(e.productPrice!) * double.parse(e.quantity!);
      total = total + itemPrice;
    }).toList();
    return total;
  }

  void getCart() async {
    try {
      // fetch from hive
      // Box box = await Hive.openBox<List<dynamic>>(HiveService.localCart);
      Box<CartListModel> box = HiveService.localCartBox ??
          await Hive.openBox<CartListModel>(HiveService.localCart);
      print("box-----------: ${box.values.first}");
      List<CartModel> data = box.values.first.cartList ?? [];
      print("data-----------: $data");
      print(box.keys.toList());
      // add in provider state
      if (data.isNotEmpty) {
        // jsonEncode(data);
        data.map((e) {
          // add v
          //aluse in provider variables
          print("11111");
          CartModel cartModel = CartModel.fromJson(json.decode(json.encode(e)));
          print("------------");
          print(e.toJson());
          print("------------");
          totalItemCount = totalItemCount + int.parse(cartModel.quantity!);
          totalItemPrice = totalItemPrice +
              (double.parse(cartModel.productPrice!)) *
                  int.parse(cartModel.quantity!);
          state.add(cartModel);
        }).toList();
        // state = data.map((e) => CartModel.fromJson(e)).toList();
        state = [...state];
      }
    } catch (error) {
      print("Error-log :$error");
    }
  }

  void addCart(CartModel cartData) async {
    try {
      // add new data in hive
      // Box box = await Hive.openBox<List<dynamic>>(HiveService.localCart);
      Box<CartListModel> box = HiveService.localCartBox ??
          await Hive.openBox<CartListModel>(HiveService.localCart);
      // box.add(cartData);

      print("added Successfully");
      // add valuse in provider variables
      totalItemCount = totalItemCount + int.parse(cartData.quantity!);
      totalItemPrice = totalItemPrice +
          (double.parse(cartData.productPrice!)) *
              int.parse(cartData.quantity!);
      // add in provider state
      state = [...state, cartData];
      box.put(0, CartListModel(cartList: state));
    } catch (error) {
      print("Error-log :$error");
    }
  }

  void updateCart(CartModel cartData, int index) async {
    try {
      // update in hive

      // Box box = await Hive.openBox<List<dynamic>>(HiveService.localCart);
      Box<CartListModel> box = HiveService.localCartBox ??
          await Hive.openBox<CartListModel>(HiveService.localCart);
      // box.put(index, cartData);
      List<CartModel> tempCartList = state;
      // Subtract previous value
      totalItemPrice = totalItemPrice -
          (double.parse(state[index].productPrice!)) *
              int.parse(state[index].quantity!);
      totalItemCount = totalItemCount - int.parse(state[index].quantity!);
      // Add New Value
      totalItemPrice = totalItemPrice +
          (double.parse(cartData.productPrice!)) *
              int.parse(cartData.quantity!);
      totalItemCount = totalItemCount + int.parse(cartData.quantity!);
      // update in porvider state
      tempCartList[index] = cartData;
      print("Wishlist Updated Successfully");
      state = [...state];
      box.put(0, CartListModel(cartList: state));
    } catch (error) {
      print("Error-log :$error");
    }
  }

  void deleteCart(int index) async {
    try {
      // remove from hive
      Box<CartListModel> box = HiveService.localCartBox ??
          await Hive.openBox<CartListModel>(HiveService.localCart);
      // box.deleteAt(index);
      List<CartModel> tempCartList = state;
      // Subtract previous value
      totalItemPrice = totalItemPrice -
          (double.parse(state[index].productPrice!)) *
              int.parse(state[index].quantity!);
      totalItemCount = totalItemCount - int.parse(state[index].quantity!);
      // remove from provider state
      tempCartList.removeAt(index);
      print("Wishlist Deleted Successfully");
      state = [...state];
      box.put(0, CartListModel(cartList: state));
      // box.put(0, state);
    } catch (error) {
      print("Error-log :$error");
    }
  }
}
