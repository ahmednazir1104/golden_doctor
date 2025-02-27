import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golden_doctor/graph_ql/config.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/home_model/home_model.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SectionsNotifier extends StateNotifier<AsyncValue<MainResponse?>> {
  SectionsNotifier() : super(const AsyncValue.loading());

  Future<void> fetchSections() async {
    log('in the fetch section');
    //  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // Fetch data from Firestore
      // final doc = await FirebaseFirestore.instance
      //     .collection('home_page')
      //     .doc('homepage_sections')
      //     .get();

      final doc = await FirebaseFirestore.instance
          .collection('home_page')
          .doc('homepage_sections')
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        // log('data ===== $data');
        // final sectionsModel = HomeModel.fromJson(data);
        MainResponse response = MainResponse.fromJson(data);
        // log('sectionsModel  ===== ${response.sections[0]}');
        state = AsyncValue.data(response);
      } else {
        throw Exception("Document does not exist or has no data");
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Fetch products by product ids
  Future<List<ProductNode>?> fetchProducts({String? productIDs}) async {
    if (productIDs == null) return null;

    GraphQlHelper graphQlHelper = GraphQlHelper();
    QueryResult result = await graphQlHelper.client.value.query(
      QueryOptions(
        document: gql(fetchProductListByIDs(productIDs)),
      ),
    );

    if (result.hasException) {
      if (kDebugMode) {
        print("GraphQL Error: ${result.exception!.graphqlErrors}");
      }
      return null;
    }

    // Data collectionProducts = Data.fromJson(result.data!);
    List<ProductNode> productList = [];
    if (result.data!['nodes'] != null) {
      // print("1111111111111111111");
      // print(json.encode(result.data!));
      // print("2222222222222222222");

      result.data!['nodes']
          .map((e) => productList.add(ProductNode.fromJson((e))))
          .toList();
      // print("33333333333333333333333333333333");
    }
    // print("productList.length");
    // print(productList.length);
    return productList;
  }

 }

// Create a provider for the SectionsNotifier
final sectionsProvider =
    StateNotifierProvider<SectionsNotifier, AsyncValue<MainResponse?>>(
  (ref) => SectionsNotifier(),
);

// class UploadNotifier extends StateNotifier<UploadState> {
//   UploadNotifier() : super(const UploadState());

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<void> fetchUserReviews() async {
//     print('in function ========= ');
//     try {
//       // state = state.copyWith(isLoading: true, errorMessage: null);
//       print(' after state in function ========= ');

//       final doc = await FirebaseFirestore.instance
//           .collection('home_page')
//           .doc('homepage_sections')
//           .get();
//       print(' after fetching data  in function ========= ');
//       if (doc.exists && doc.data() != null) {
//         print(' after fetching data  in function ========= ');
//         final data = doc.data()!;
//         log('Data ====== $data');
//         print('Data ===== ${json.decode(json.encode(data))}');
//         // final languages = (data['languages'] as List)
//         //     .map((language) => LanguageModel.fromMap(language))
//         //     .toList();
//         // return languages;
//       } else {
//         print('Data ===== ${doc.data()}');
//         throw Exception("Document does not exist or has no data");
//       }

//       // Query Firestore for reviews by the current user
//       // QuerySnapshot querySnapshot = await _firestore
//       //     .collection("reviews")
//       //     .get();

//       // // Convert the documents into a list of Review objects
//       // List<Review> userReviews =
//       //     querySnapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();

//       // // Update the state with the fetched reviews
//       // state = state.copyWith(
//       //   userReviews: userReviews,
//       //   isLoading: false,
//       // );
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         errorMessage: "Error fetching reviews: $e",
//       );
//     }
//   }

//   void handleStorageError(FirebaseException e) {
//     print('Error: ${e.code} - ${e.message}');

//     switch (e.code) {
//       case 'object-not-found':
//         Fluttertoast.showToast(
//             msg: 'File not found in storage.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'unauthorized':
//         Fluttertoast.showToast(
//             msg: 'You are not authorized to access this file.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'unauthenticated':
//         Fluttertoast.showToast(
//             msg: 'Please log in to access this file.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'permission-denied':
//         Fluttertoast.showToast(
//             msg: 'Access to this file is denied.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'invalid-argument':
//         Fluttertoast.showToast(
//             msg: 'Invalid argument provided. Please check the file path.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'quota-exceeded':
//         Fluttertoast.showToast(
//             msg: 'Storage quota exceeded. Upgrade your Firebase plan.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'canceled':
//         Fluttertoast.showToast(
//             msg: 'Operation was canceled.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'download-size-exceeded':
//         Fluttertoast.showToast(
//             msg: 'File size exceeds the download limit.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'retry-limit-exceeded':
//         Fluttertoast.showToast(
//             msg: 'Retry limit exceeded. Please try again later.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'invalid-checksum':
//         Fluttertoast.showToast(
//             msg: 'File checksum mismatch. Ensure the file is not corrupted.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       case 'bucket-not-found':
//         Fluttertoast.showToast(
//             msg:
//                 'Specified bucket does not exist. Check Firebase configuration.',
//             backgroundColor: AppColors.buttonColor);
//         break;
//       default:
//         Fluttertoast.showToast(
//             msg: 'An unknown storage error occurred: ${e.message}',
//             backgroundColor: AppColors.buttonColor);
//     }
//   }
// }

// final uploadProvider =
//     StateNotifierProvider<UploadNotifier, UploadState>((ref) {
//   return UploadNotifier();
// });
