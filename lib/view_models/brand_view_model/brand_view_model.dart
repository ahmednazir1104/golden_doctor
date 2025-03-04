import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getBrandProvider = FutureProvider((ref) async {
  try {
    print('========= Pages data Function =======');
    final doc = await FirebaseFirestore.instance
        .collection('pages')
        .doc('static_pages')
        .get();

    print('document Pages data ==== ${doc.data()}');

    // if (doc.exists && doc.data() != null) {
    //   return PagesData.fromMap(doc.data()!);
    // } else {
    //   throw Exception("Document does not exist or has no data");
    // }
  } catch (e) {
    print('Error fetching pages: $e');
    rethrow;
  }
});
