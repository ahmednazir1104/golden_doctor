
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/models/navigation_model/navigation_model.dart';

class NavigationViewModel extends StateNotifier<AsyncValue<NavigationModel?>> {
  NavigationViewModel() : super(const AsyncValue.loading());

  Future<void> fetchNavigation() async {
    // log('in the fetch section');
    //  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // Fetch data from Firestore
      // final doc = await FirebaseFirestore.instance
      //     .collection('home_page')
      //     .doc('homepage_sections')
      //     .get();

      final doc = await FirebaseFirestore.instance
          .collection('navigation')
          .doc('navigation')
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        // log('data ===== $data');
        final sectionsModel = NavigationModel.fromJson(data);
        // log('sectionsModel  ===== ${sectionsModel.sections[0].title}');
        state = AsyncValue.data(sectionsModel);
      } else {
        throw Exception("Document does not exist or has no data");
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Create a provider for the NavigationViewModel
final navigationprovider =
    StateNotifierProvider<NavigationViewModel, AsyncValue<NavigationModel?>>(
  (ref) => NavigationViewModel(),
);
