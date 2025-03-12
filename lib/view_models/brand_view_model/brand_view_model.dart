import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/models/brands_model/brands_model.dart';

// final getBrandProvider = FutureProvider<BrandsModel>((ref) async {
//   try {
//     print('========= Brand data Function =======');
//     final doc = await FirebaseFirestore.instance
//         .collection('brands')
//         .doc('brands')
//         .get();
// log('document Pages data ==== ${doc.data()}');
//     print('document Pages data ==== ${doc.data()}');

//     if (doc.exists && doc.data() != null) {
//       return BrandsModel.fromJson(doc.data()!);
//     } else {
//       throw Exception("Document does not exist or has no data");
//     }
//   } catch (e) {
//     print('Error fetching pages: $e');
//     rethrow;
//   }
// });



final getBrandProvider = FutureProvider<BrandsModel>((ref) async {
  try {
    print('========= Fetching Brands =======');
    final doc = await FirebaseFirestore.instance
        .collection('brands')
        .doc('brands')
        .get();

    if (doc.exists && doc.data() != null) {
      return BrandsModel.fromJson(doc.data()!);
    } else {
      throw Exception("Document does not exist or has no data");
    }
  } catch (e) {
    print('Error fetching brands: $e');
    rethrow;
  }
});


// final getBrandProvider = FutureProvider<List<BrandsModel>>((ref) async {
//   try {
//     final doc = await FirebaseFirestore.instance
//         .collection('brands')
//         .doc('brands')
//         .get();

//     if (doc.exists && doc.data() != null) {
//       final data = doc.data()!;
//       final brandsList = (data['brands'] as List)
//           .map((brand) => BrandsModel.fromJson(brand))
//           .toList();
//       log('Colors List === ${brandsList[0].brands!.length}');
//       return brandsList;
//     } else {
//       throw Exception("Document does not exist or has no data");
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error fetching Colors: $e');
//     }
//     rethrow;
//   }
// });



/// Riverpod Provider
// final getBrandProvider = FutureProvider<List<BrandsModel>>((ref) async {
//   try {
//     final doc = await FirebaseFirestore.instance
//         .collection('brands')
//         .doc('brands')
//         .get();

//     if (doc.exists && doc.data() != null) {
//       final data = doc.data()!;
//       final brandsList = (data['brands'] as List)
//           .map((brand) => BrandsModel.fromJson(brand))
//           .toList();
//       log('Brands List === ${brandsList.length}');
//       return brandsList;
//     } else {
//       throw Exception("Document does not exist or has no data");
//     }
//   } catch (e) {
//     debugPrint('Error fetching Brands: $e');
//     rethrow;
//   }
// });

