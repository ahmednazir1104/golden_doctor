import 'dart:io';

import 'package:golden_doctor/models/cart/cart_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  // static String localWishList = 'WsihListBox';
  static Box<CartListModel>? localCartBox;
  static String localCart = 'CartBox';

  static Future hiveinitialize() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive
      ..init(directory.path)
      // ..registerAdapter(WishListAdapter())
      ..registerAdapter(CartListModelAdapter())
      ..registerAdapter(CartModelAdapter())
      ..registerAdapter(EmbroideryOptionsAdapter());
    // locaWishListBox = await Hive.openBox<WishlistModel>(localWishList);
    localCartBox = await Hive.openBox<CartListModel>(localCart);
  }

  static getFromHive({required String table, required String key}) async {
    var box = Hive.box(table);
    var list = await box.get(key);
    return list;
  }

  static addToHive({required String table, required String key, dynamic data}) {
    String response = "";
    // adding to hive DB.
    var box = Hive.box(table);
    box.put(key, data).then((value) {
      // print("Cart added to hive");
    }).onError((error, stackTrace) {
      // print("Error in adding cart to hive");
      // print(error);
      // print(stackTrace);
      response = error.toString();
    });
    return response;
  }

  static deleteFromHive(
      {required String table, required String key, required int index}) async {
    var box = Hive.box(table);
    List list = await box.get(key);
    list.removeAt(index);
    box.put(key, list);
  }
}
